//  QuizInspiration.swift
//  QuizMaster
//


import Foundation

struct QuizInspiration: Identifiable, Codable {
    
    var quizCollectionIDName: String
    var name: String
    var description: String
    var imageName: String
    var id = UUID()
    var imageURL: URL?

    
    static func examples() -> [QuizInspiration] {
        [
            QuizInspiration(quizCollectionIDName: "ExerciseForC#", name: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI",name: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForC#", name: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI",name: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForC#", name: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI",name: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForC#", name: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp"),
            
            QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI",name: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI"),
        
        ]
    }
    
    static func exampleCSharp() -> QuizInspiration {
        QuizInspiration(quizCollectionIDName: "ExerciseForC#", name: "Exercise For C#", description: "This quiz contains all exercise questions related to c#", imageName: "CSharp")
    }
    
    static func exampleSwiftUI() -> QuizInspiration {
        QuizInspiration(quizCollectionIDName: "ExerciseForSwiftUI", name: "Exercise For SwiftUI", description: "This quiz contains all exercise questions related to SwiftUI", imageName: "SwiftUI")
    }
}
