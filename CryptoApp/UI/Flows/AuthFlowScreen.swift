//
//  AuthFlowScreen.swift
//  CryptoApp
//
//  Created by Nikita on 02/04/2024.
//

import SwiftUI

enum AuthFlowState: Hashable{
    case register
}

struct AuthFlowScreen: View {
    @State var onComplete: () -> Void
    var body: some View{
        NavigationStack{
            LoginView(onLogin: onComplete)
                .navigationDestination(for: AuthFlowState.self) { state in
                    switch state{
                    case .register:
                        RegisterView(onRegister: onComplete)
                    }
                }
        }
    }

}

#Preview {
    AuthFlowScreen(onComplete: {})
}
