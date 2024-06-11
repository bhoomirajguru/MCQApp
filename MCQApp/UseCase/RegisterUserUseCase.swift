//
//  RegisterUserUseCase.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation

class RegisterUserUseCase {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func execute(user: User, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        networkService.registerUser(user: user, completion: completion)
    }
}
