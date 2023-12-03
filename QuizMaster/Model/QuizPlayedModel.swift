//
//  QuizPlayedModel.swift
//  QuizMaster
//

import Foundation
import FirebaseFirestoreSwift

// MARK: Quiz Model
struct QuizPlayedModel: Identifiable,Codable {
    @DocumentID var id: String?
    // MARK: Quiz Played Meta Info
    var quizReferenceID: String
    var title: String
    var description: String
    var imageURL: URL?
    // MARK: Quiz Played Info
    var score: CGFloat
    var publishedDate: Date = Date()
    // MARK: Basic User Info
    var userName: String
    var userUID: String
    var userProfileURL: URL
    
    enum CodingKeys: CodingKey {
        case id
        case quizReferenceID
        case title
        case description
        case imageURL
        case score
        case publishedDate
        case userName
        case userUID
        case userProfileURL
    }
    
}
