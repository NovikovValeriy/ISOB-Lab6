//
//  AuthenticationViewModel.swift
//  SQL-Injection
//
//  Created by Валерий Новиков on 15.04.25.
//

import SwiftUI

class AuthenticationViewModel: ObservableObject {
    @Published var loginText: String = ""
    @Published var passwordText: String = ""
}
