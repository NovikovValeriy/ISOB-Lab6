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
        GeometryReader { _ in
            VStack {
                
                Spacer()
                
                //                Text("Защита от SQL-инъекций")
                //                    .font(.system(size: 38, weight: .bold, design: .default))
                //                    .fontWeight(.bold)
                //                    .foregroundStyle(.primary)
                //                    .multilineTextAlignment(.center)
                //
                //
                //                Spacer()
                Image(systemName: "tablecells")
                    .foregroundStyle(.primary)
                    .font(.system(size: 80))
                    .padding(.bottom, 5)
                Text("Защита от SQL-инъекций")
                    .foregroundStyle(.primary)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                
                TextField(
                    "",
                    text: $authVM.loginText,
                    prompt: Text("Имя пользователя")
                )
                .font(.system(size: 18, weight: .regular, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 60)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(.primary, lineWidth: 2)
                }
                
                HStack {
                    if isPasswordShown {
                        TextField(
                            "",
                            text: $authVM.passwordText,
                            prompt: Text("Пароль")
                        )
                        .foregroundStyle(.primary)
                    } else {
                        SecureField(
                            "",
                            text: $authVM.passwordText,
                            prompt: Text("Пароль")
                        )
                        .foregroundStyle(.primary)
                    }
                    Image(systemName: isPasswordShown ? "eye.slash" : "eye")
                        .onTapGesture {
                            isPasswordShown.toggle()
                        }
                        .font(.system(size: 22, weight: .regular, design: .default))
                }
                .foregroundStyle(.primary)
                .font(.system(size: 18, weight: .regular, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 60)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.horizontal, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(.primary, lineWidth: 2)
                }
                
                Toggle("Защищенный режим", isOn: $authVM.secureMode)
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    .padding(.top, 10)
                
                
                Spacer()
                
                Button {
                    if authVM.areCredentialsValid {
                        authVM.login()
                    } else {
                        authVM.alertTitle = "Ошибка"
                        authVM.alertText = "Имя пользователя и пароль могут содержать только латинские буквы, цифры и знаки \"-\", \"_\", а также быть от 4 до 16 символов в длину."
                        authVM.showingAlert = true
                    }
                } label: {
                    Text("Войти")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                
                Button {
                    if authVM.areCredentialsValid {
                        authVM.register()
                    } else {
                        authVM.alertTitle = "Ошибка"
                        authVM.alertText = "Имя пользователя и пароль могут содержать только латинские буквы, цифры и знаки \"-\", \"_\", а также быть от 4 до 16 символов в длину."
                        authVM.showingAlert = true
                    }
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
            //.padding(.bottom, 300)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    AuthenticationView()
}
