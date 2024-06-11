//
//  RegisterViewModel.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String?

    private let registerUserUseCase: RegisterUserUseCase
    private var cancellables = Set<AnyCancellable>()

    init(registerUserUseCase: RegisterUserUseCase) {
        self.registerUserUseCase = registerUserUseCase
        print("RegisterViewModel initialized")
    }

    func register() {
        let user = User(email: email, password: password)
        print("Register method called with user: \(user)")
        registerUserUseCase.execute(user: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isRegistered = true
                    print("User registration successful")
                case .failure(let error):
                    self?.isRegistered = false
                    self?.errorMessage = error.localizedDescription
                    print("User registration failed with error: \(error)")
                }
            }
        }
    }
}
