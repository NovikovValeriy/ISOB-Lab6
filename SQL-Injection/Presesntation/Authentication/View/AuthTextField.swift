//
//  AuthTextField.swift
//  SQL-Injection
//
//  Created by Валерий Новиков on 16.04.25.
//

import SwiftUI

struct AuthTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField("", text: $text, prompt: Text(placeholder))
            .font(.system(size: 18, weight: .regular, design: .default))
            .frame(maxWidth: .infinity, maxHeight: 60)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal, 20)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(.primary, lineWidth: 2)
            }
    }
}
