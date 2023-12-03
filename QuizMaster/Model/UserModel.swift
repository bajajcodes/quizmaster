//
//  UserModel.swift
//  QuizMaster
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String
    var userBio: String
    var userUID: String
    var userEmail: String
    var userProfileURL: URL
    var score: CGFloat
    
    enum CodingKeys: CodingKey {
        case id
        case username
        case userBio
        case userUID
        case userEmail
        case userProfileURL
        case score
    }
}
