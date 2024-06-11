//
//  LoginView.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        print("LoginView initialized")
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

            Button("Login") {
                viewModel.login()
            }
            .padding()

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .onAppear {
                        print("Error message displayed: \(errorMessage)")
                    }
            }

            if viewModel.isLoggedin {
                NavigationLink(destination: InspectionListView()) {
                    Text("Go to Destination View")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Text("Login Successful!")
                    .foregroundColor(.green)
                    .onAppear {
                        print("Login successful message displayed")
                    }
            }
        }
        .padding()
        .onAppear {
            print("LoginView appeared")
        }
    }
}
