//
//  InsoectionViewModel.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation

import SwiftUI
import Combine

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var selectedOption: [Int: Int] = [:] // Dictionary to hold selected options for each question
    
    private var cancellable: AnyCancellable?
    var subscriptions = Set<AnyCancellable>()
    
    func fetchQuestions() {
        guard let url = URL(string: "http://localhost:5001/api/inspections/start") else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: InspectionResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching questions: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { inspectionResponse in
                self.questions = inspectionResponse.inspection.survey.categories.flatMap { $0.questions }
            })
    }
    
    func toggleOption(for questionId: Int, optionId: Int) {
        if selectedOption[questionId] == optionId {
            // Deselect if already selected
            selectedOption[questionId] = nil
        } else {
            // Select option
            selectedOption[questionId] = optionId
        }
    }
    
    func isSelectedOption(for questionId: Int, optionId: Int) -> Bool {
        return selectedOption[questionId] == optionId
    }
}






