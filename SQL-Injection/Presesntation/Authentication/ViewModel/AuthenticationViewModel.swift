//
//  AuthenticationViewModel.swift
//  SQL-Injection
//
//  Created by Валерий Новиков on 15.04.25.
//

import SwiftUI
import GRDB

class AuthenticationViewModel: ObservableObject {
    @Published var loginText: String = ""
    @Published var passwordText: String = ""
    @Published var secureMode: Bool = false
    
    @Published var isPasswordShown: Bool = false
    
    @Published var showingAlert = false
    @Published var alertTitle = ""
    @Published var alertText = ""
    
    private var dbQueue: DatabaseQueue?
    
    var areCredentialsValid: Bool {
        let regex = "^[a-zA-Z0-9_-]{4,16}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: loginText)
    }
        
    init() {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("db.sqlite")
            
            dbQueue = try DatabaseQueue(path: fileURL.path)
            
            try dbQueue?.write { db in
                try db.create(table: "users") { t in
                    t.autoIncrementedPrimaryKey("id")
                    t.column("username", .text).notNull().unique()
                    t.column("password", .text).notNull()
                }
            }
        } catch {
            print("Ошибка инициализации базы данных: \(error)")
        }
    }
    
    func login() {
        var result: Bool
        if secureMode {
            result = self.safeLogin()
        } else {
            result = self.unsafeLogin()
        }
        
        if result {
            alertTitle = "Успех"
            alertText = "Аутентификация успешна"
        } else {
            alertTitle = "Ошибка"
            alertText = "Ошибка аутентификации"
        }
        
        showingAlert = true
    }
    
    func register() {
        var result: Bool
        if secureMode {
            result = self.safeRegister()
        } else {
            result = self.unsafeRegister()
        }
        
        if result {
            alertTitle = "Успех"
            alertText = "Регистрация успешна"
        } else {
            alertTitle = "Ошибка"
            alertText = "Ошибка регистрации"
        }
        
        showingAlert = true
    }
    
    private func unsafeLogin() -> Bool {
        let query = "SELECT * FROM users WHERE username = '\(self.loginText)' AND password = '\(self.passwordText)';"
        
        do {
            let result = try dbQueue?.read { db in
                if try Row.fetchOne(db, sql: query) != nil {
                    return true
                }
                return false
            }
            return result ?? false
        } catch {
            print("Ошибка выполнения запроса: \(error)")
        }
        
        return false
    }
    
    private func safeLogin() -> Bool {
        let query = "SELECT * FROM users WHERE username = ? AND password = ?;"
        
        do {
            let result = try dbQueue?.read { db in
                if try Row.fetchOne(db, sql: query, arguments: [self.loginText, self.passwordText]) != nil {
                    return true
                }
                return false
            }
            return result ?? false
        } catch {
            print("Ошибка выполнения запроса: \(error)")
        }
        
        return false
    }
    
    private func unsafeRegister() -> Bool {
        let query = "INSERT INTO users (username, password) VALUES ('\(self.loginText)', '\(self.passwordText)');"
        
        do {
            try dbQueue?.write { db in
                try db.execute(sql: query)
            }
            return true
        } catch {
            print("Ошибка выполнения запроса: \(error)")
        }
        
        return false
    }
    
    private func safeRegister() -> Bool {
        let query = "INSERT INTO users (username, password) VALUES (?, ?);"
        
        do {
            try dbQueue?.write { db in
                try db.execute(sql: query, arguments: [self.loginText, self.passwordText])
            }
            return true
        } catch {
            print("Ошибка выполнения запроса: \(error)")
        }
        
        return false
    }
    
}
