//
//  LoginViewModel.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation

import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedin: Bool = false
    @Published var errorMessage: String?

    private let loginUserUseCase: LoginUserUseCase
    private var cancellables = Set<AnyCancellable>()

    init(loginUserUseCase: LoginUserUseCase) {
        self.loginUserUseCase = loginUserUseCase
        print("LoginViewModel initialized")
    }

    func login() {
        let user = User(email: email, password: password)
        print("Login method called with user: \(user)")
        loginUserUseCase.execute(user: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isLoggedin = true
                    print("User login successful")
                case .failure(let error):
                    self?.isLoggedin = false
                    self?.errorMessage = error.localizedDescription
                    print("User login failed with error: \(error)")
                }
            }
        }
    }
}
