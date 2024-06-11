//
//  LoginUserUseCase.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation

class LoginUserUseCase {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func execute(user: User, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        networkService.loginUser(user: user, completion: completion)
    }
}
