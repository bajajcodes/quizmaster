//
//  Question.swift
//  QuizMaster
//


import SwiftUI
import FirebaseFirestoreSwift


struct Question:  Identifiable, Codable{
    @DocumentID var id: String?
    var question: String;
    var answer: String;
    var options: [String];
    
    var tappedAnswer: String  = "";
    
    enum CodingKeys: CodingKey {
        case id
        case question
        case options
        case answer
    }
}
