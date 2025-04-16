//
//  AuthenticationView.swift
//  SQL-Injection
//
//  Created by Валерий Новиков on 15.04.25.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var authVM = AuthenticationViewModel()
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                
                Spacer()
                
                Image(systemName: "tablecells")
                    .foregroundStyle(.primary)
                    .font(.system(size: 80))
                    .padding(.bottom, 5)
                Text("Защита от SQL-инъекций")
                    .foregroundStyle(.primary)
                    .font(.system(size: 26, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                
                AuthTextField(placeholder: "Имя пользователя", text: $authVM.loginText)
                
                AuthSecureField(placeholder: "Пароль", text: $authVM.passwordText, isPasswordShown: $authVM.isPasswordShown)
                
                Toggle("Защищенный режим", isOn: $authVM.secureMode)
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    .padding(.top, 10)
                
                Spacer()
                
                Button {
                    handleButtonAction(action: authVM.login)
                } label: {
                    Text("Войти")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                
                Button {
                    handleButtonAction(action: authVM.register)
                } label: {
                    Text("Зарегистрироваться")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(.white)
                        .background(Color.secondary.opacity(0.8))
                        .cornerRadius(10)
                }
            }
            .alert(authVM.alertTitle, isPresented: $authVM.showingAlert) {
                Button("OK") { }
            }
            message: {
                Text(authVM.alertText)
            }
            .padding(20)
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private func handleButtonAction(action: () -> Void) {
        if authVM.areCredentialsValid {
            action()
        } else {
            authVM.alertTitle = "Ошибка"
            authVM.alertText = "Имя пользователя и пароль могут содержать только латинские буквы, цифры и знаки \"-\", \"_\", а также быть от 4 до 16 символов в длину."
            authVM.showingAlert = true
        }
    }
}

#Preview {
    AuthenticationView()
}
