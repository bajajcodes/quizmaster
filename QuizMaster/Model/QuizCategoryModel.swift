//
//  QuizCategoryModel.swift
//  QuizMaster


import Foundation
import FirebaseFirestoreSwift

struct QuizCategoryModel: Identifiable, Codable {
    
    @DocumentID var id: String?
    var title: String
    var description: String
    var imageURL: URL
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case description
        case imageURL
    }
    
}
