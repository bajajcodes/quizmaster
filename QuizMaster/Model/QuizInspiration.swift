//  QuizInspiration.swift
//  QuizMaster


import Foundation
import FirebaseFirestoreSwift

struct QuizInspiration: Identifiable, Codable {
    
    @DocumentID var id: String?
    var quizCollectionIDName: String
    var title: String
    var description: String
    var imageName: String?
    var imageURL: URL
    
    enum CodingKeys: CodingKey {
        case id
        case quizCollectionIDName
        case title
        case description
        case imageURL
    }
    
}
