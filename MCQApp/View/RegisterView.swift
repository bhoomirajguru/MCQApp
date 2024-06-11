//
//  Registration.swift
//  MCQApp
//
//  Created by Apple on 05/06/24.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel

    init(viewModel: RegisterViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        print("RegisterView initialized")
    }

    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: viewModel.email) { oldValue, newValue in
                }

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: viewModel.password) { oldValue, newValue in
                }

            Button("Register") {
                viewModel.register()
            }
            .padding()

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .onAppear {
                        print("Error message displayed: \(errorMessage)")
                    }
            }

            if viewModel.isRegistered {
                Text("Registration Successful!")
                    .foregroundColor(.green)
                    .onAppear {
                        print("Registration successful message displayed")
                    }
            }
        }
        .padding()
        .onAppear {
            print("RegisterView appeared")
        }
    }
}


