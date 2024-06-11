//
//  Inspection.swift
//  MCQApp
//
//  Created by Apple on 06/06/24.
//

import Foundation

struct InspectionResponse: Decodable {
    let inspection: Inspection
}

struct Inspection: Decodable {
    let area: Area
    let id: Int
    let inspectionType: InspectionType
    let survey: Survey
}

struct Area: Decodable {
    let id: Int
    let name: String
}

struct InspectionType: Decodable {
    let access: String
    let id: Int
    let name: String
}

struct Survey: Decodable {
    let categories: [Category]
    let id: Int
}

struct Category: Decodable {
    let id: Int
    let name: String
    let questions: [Question]
}

//struct Question: Decodable, Identifiable {
//    let id: Int
//    let name: String
//    let answerChoices: [AnswerChoice]
//    let selectedAnswerChoiceId: Int?
//}
//
//struct AnswerChoice: Decodable, Identifiable, Hashable {
//    let id: Int
//    let name: String
//    let score: Double
//}

struct Question: Identifiable, Codable {
    var id: String
    var name: String
    var answerChoices: [AnswerChoice]
}

struct AnswerChoice: Identifiable, Codable {
    var id: String
    var name: String
}
