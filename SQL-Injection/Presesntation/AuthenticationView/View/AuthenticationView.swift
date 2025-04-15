//
//  AuthenticationView.swift
//  SQL-Injection
//
//  Created by Валерий Новиков on 15.04.25.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var authVM = AuthenticationViewModel()
    @State var isPasswordShown = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            Spacer()
            
            TextField(
                "",
                text: $authVM.loginText,
                prompt: Text("Имя пользователя").foregroundStyle(.secondary)
            )
            .font(.system(size: 18, weight: .regular, design: .default))
            .frame(maxWidth: .infinity, maxHeight: 60)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal, 20)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(.secondary, lineWidth: 2)
            }
            
            HStack {
                if isPasswordShown {
                    TextField(
                        "",
                        text: $authVM.passwordText,
                        prompt: Text("Пароль").foregroundStyle(.secondary)
                    )
                } else {
                    SecureField(
                        "",
                        text: $authVM.passwordText,
                        prompt: Text("Пароль").foregroundStyle(.secondary)
                    )
                }
                Button {
                    isPasswordShown.toggle()
                } label: {
                    Image(systemName: isPasswordShown ? "eye.slash" : "eye")
                }
                .font(.system(size: 22, weight: .regular, design: .default))
                .foregroundStyle(.secondary)
            }
            .font(.system(size: 18, weight: .regular, design: .default))
            .frame(maxWidth: .infinity, maxHeight: 60)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal, 20)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(.secondary, lineWidth: 2)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Войти")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .foregroundColor(Color.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            
            Button {
                
            } label: {
                Text("Зарегистрироваться")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .foregroundColor(.white)
                    .background(Color.secondary)
                    .cornerRadius(10)
            }
        }
        .padding(20)
    }
}

#Preview {
    AuthenticationView()
}
