//
//  Info.swift
//  QuizMaster
//

import SwiftUI

struct Info: Codable{
    var title: String;
    var peopleAttended: Int;
    var rules: [String];
    
    enum CondingKeys: CodingKey {
        case title
        case peopleAttended
        case rules
    }
}
