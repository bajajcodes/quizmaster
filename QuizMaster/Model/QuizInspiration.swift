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
    var imageURL: URL?
    
    enum CodingKeys: CodingKey {
        case id
        case quizCollectionIDName
        case title
        case description
        case imageURL
    }
    
    static func examples() -> [QuizInspiration] {
        [
            QuizInspiration(quizCollectionIDName: "ExerciseForC#", title: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI",title: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForC#", title: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI",title: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForC#", title: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI",title: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForC#", title: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI",title: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI"),
        
        ]
    }
    
    static func exampleCSharp() -> QuizInspiration {
        QuizInspiration(quizCollectionIDName: "ExerciseForC#", title: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp")
    }
    
    static func exampleSwiftUI() -> QuizInspiration {
        QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI", title: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI")
    }
}
