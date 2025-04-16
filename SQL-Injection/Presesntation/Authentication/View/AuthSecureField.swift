//
//  AuthSecureField.swift
//  SQL-Injection
//
//  Created by Валерий Новиков on 16.04.25.
//

import SwiftUI

struct AuthSecureField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var isPasswordShown: Bool
    
    var body: some View {
        HStack {
            if isPasswordShown {
                TextField("", text: $text, prompt: Text(placeholder))
            } else {
                SecureField("", text: $text, prompt: Text(placeholder))
            }
            Image(systemName: isPasswordShown ? "eye.slash" : "eye")
                .onTapGesture {
                    isPasswordShown.toggle()
                }
                .font(.system(size: 22, weight: .regular, design: .default))
        }
        .font(.system(size: 18, weight: .regular, design: .default))
        .frame(maxWidth: .infinity, maxHeight: 60)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .padding(.horizontal, 20)
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.primary, lineWidth: 2)
        }
    }
}
