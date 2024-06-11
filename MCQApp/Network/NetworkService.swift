//
//  NetworkService.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
}

class NetworkService {
    private let baseURL = "http://localhost:5001/api"

    func registerUser(user: User, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/register") else {
            completion(.failure(.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            request.httpBody = data
        } catch {
            completion(.failure(.unknown))
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.unknown))
                return
            }

            completion(.success(()))
        }.resume()
    }

    func loginUser(user: User, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
            completion(.failure(.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            request.httpBody = data
        } catch {
            completion(.failure(.unknown))
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.unknown))
                return
            }

            completion(.success(()))
        }.resume()
    }
    
//    func startInspection() -> AnyPublisher<Inspection, Error> {
//        let url = URL(string: "\(baseURL)/inspections/start")!
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: Inspection.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
    //}
}


