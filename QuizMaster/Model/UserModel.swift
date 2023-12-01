//
//  UserModel.swift
//  QuizMaster
//
//  Created by Shubham Bajaj on 02/12/23.
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
    
    enum Codingkeys: CodingKey {
        case id
        case username
        case userBio
        case userUID
        case userEmail
        case userProfileURL
    }
}
