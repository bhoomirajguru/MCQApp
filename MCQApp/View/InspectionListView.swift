//
//  InspectionView.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation

import SwiftUI
import Combine

struct IdentifiableString: Identifiable {
    var id: String { self.value }
    let value: String
}

struct InspectionListView: View {
    @ObservedObject var viewModel = QuestionViewModel()
    @State private var showingScore = false
    @State private var score = 0
    @State private var submissionError: IdentifiableString? = nil
    let submitURL = URL(string: "http://localhost:5001/api/inspections/submit")! // Replace with your actual URL
    
    var body: some View {
        NavigationView {
            List(viewModel.questions) { question in
                VStack(alignment: .leading) {
                    Text(question.name)
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ForEach(question.answerChoices.indices, id: \.self) { index in
                        let choice = question.answerChoices[index]
                        Button(action: {
                            viewModel.toggleOption(for: question.id, optionId: choice.id)
                        }) {
                            HStack {
                                Image(systemName: viewModel.isSelectedOption(for: question.id, optionId: choice.id) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(viewModel.isSelectedOption(for: question.id, optionId: choice.id) ? .blue : .black)
                                Text(choice.name)
                            }
                        }
                        .padding(.vertical, 2)
                    }
                }
                .padding(.vertical, 10)
            }
            .navigationBarTitle("Multiple Choice Questions")
            .navigationBarItems(trailing:
                Button(action: {
                    submissionError = nil // Reset submission error
                    calculateScore()
                }) {
                    Text("Submit")
                }
            )
            .alert(item: $submissionError) { errorMessage in
                Alert(title: Text("Error"), message: Text(errorMessage.value), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showingScore) {
                ScoreView(score: score)
            }
            .onAppear {
                viewModel.fetchQuestions()
            }
        }
    }
    
    func calculateScore() {
        // Implement your score calculation logic here
        // For now, let's just count the number of selected options
        score = viewModel.questions.reduce(0) { (result, question) in
            result + question.answerChoices.filter { viewModel.isSelectedOption(for: question.id, optionId: $0.id) }.count
        }
        
        // Call the API
        submitInspection()
    }
    
    func submitInspection() {
        guard let encoded = try? JSONEncoder().encode(viewModel.questions) else {
            submissionError = IdentifiableString(value: "Failed to encode inspection data.")
            return
        }
        
        var request = URLRequest(url: submitURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encoded
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    submissionError = IdentifiableString(value: "Failed to submit inspection: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in
                // Handle success if needed
                showingScore = true // Show score after successful submission
            })
            .store(in: &viewModel.subscriptions)
    }
}

struct ScoreView: View {
    let score: Int
    
    var body: some View {
        Text("Your Score: \(score)")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }
}

struct InspectionListView_Previews: PreviewProvider {
    static var previews: some View {
        InspectionListView()
    }
}



