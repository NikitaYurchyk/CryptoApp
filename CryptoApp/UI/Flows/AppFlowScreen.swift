//
//  ViewsManager.swift
//  CryptoApp
//
//  Created by Nikita on 02/04/2024.
//

import SwiftUI

enum AppFlowState{
    case AUTH
    case MAIN
}



struct AppFlowScreen: View {
    @State var appFlowState: AppFlowState = .AUTH
    let onComplete: () -> Void
    var body: some View {
        switch appFlowState{
        case .AUTH:
            AuthFlowScreen(onComplete: {
                appFlowState = .MAIN
            })
        case .MAIN:
            HomeView()
        }
    }
}

#Preview {
    AppFlowScreen(onComplete: {})
}
