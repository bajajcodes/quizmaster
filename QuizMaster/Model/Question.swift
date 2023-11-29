//
//  Question.swift
//  QuizMaster
//


import SwiftUI

struct Question: Codable{
    var id: UUID = .init();
    var question: String;
    var answer: String;
    var options: [String];
    
    var tappedAnswer: String  = "";
    
    enum CondingKeys: CodingKey {
        case question
        case options
        case answer
    }
}
