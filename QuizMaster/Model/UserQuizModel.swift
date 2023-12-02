//
//  QuizModel.swift
//  QuizMaster
//


import Foundation

struct UserQuizModel: Identifiable {
    
    var id = UUID()
    var quizCollectionIDName: String
    var quizName: String
    var quizScore: String
    var quizTakenAt: String
    var quizProfileURL: URL?
    
    enum CodingKeys: CodingKey {
        case quizCollectionIDName
        case quizName
        case quizScore
        case quizTakenAt
        case quizProfileURL
    }

}
