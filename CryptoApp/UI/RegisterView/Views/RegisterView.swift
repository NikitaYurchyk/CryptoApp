//
//  RegisterView.swift
//  CryptoApp
//
//  Created by Nikita on 02/04/2024.
//

import SwiftUI

struct RegisterView: View {
    @State var onRegister: () -> Void
    @State var login: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    var body: some View {
        ScrollView{
            VStack{
                TextField("Your new login", text: $login)
                TextField("Your password", text: $password)
                TextField("Repeat the password", text: $repeatPassword)
                Button("Enter", action: onRegister)
                    .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 30)
        }
        .textFieldStyle(.roundedBorder)
        .navigationTitle("Registration")
        .offset(y:180)

    }
}

#Preview {
    RegisterView(onRegister: {})
}
