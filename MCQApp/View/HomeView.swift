//
//  HomeView.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Login", value: NavigationDestination.login)
                    .padding()
                
                NavigationLink("Register", value: NavigationDestination.register)
                    .padding()
            }
            .navigationTitle("Welcome")
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .login:
                    LoginView(viewModel: LoginViewModel(loginUserUseCase: LoginUserUseCase(networkService: NetworkService())))
                case .register:
                    RegisterView(viewModel: RegisterViewModel(registerUserUseCase: RegisterUserUseCase(networkService: NetworkService())))
                }
            }
        }
    }
}

enum NavigationDestination: Hashable {
    case login
    case register
}

