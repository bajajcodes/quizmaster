//
//  QuizInfoModel.swift
//  QuizMaster


import Foundation
import FirebaseFirestoreSwift

struct QuizInfoModel: Identifiable, Codable {
    
    @DocumentID var id: String?
    var description: String
    var imageURL: URL
    var title: String;
    var peopleAttended: Int;
    var rules: [String];
    
    enum CondingKeys: CodingKey {
        case id
        case title
        case peopleAttended
        case rules
        case description
        case imageURL
    }
}
