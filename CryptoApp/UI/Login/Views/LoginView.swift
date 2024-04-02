//
//  LoginView.swift
//  CryptoApp
//
//  Created by Nikita on 02/04/2024.
//

import SwiftUI

struct LoginView: View {
    @State var login: String = ""
    @State var password: String = ""
    let onLogin: () -> Void
    var body: some View {
        ScrollView{
            VStack{
                TextField("Login", text: $login)
                
                TextField("Passwords", text: $password)
                
                Button("Enter", action: onLogin)
                .buttonStyle(.borderedProminent)
                NavigationLink("Sign-Up", value: AuthFlowState.register)

            }
        }
        .padding(30)
        .textFieldStyle(.roundedBorder)
        .offset(y:180)

    }
}

#Preview {
    LoginView(onLogin: {})
}
