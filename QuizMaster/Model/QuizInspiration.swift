//
//  QuizInspiration.swift
//  QuizMaster
//


import Foundation

struct QuizInspiration: Identifiable {
    
    let quizCollectionIDName: String
    let name: String
    let description: String
    let imageName: String
    let id = UUID()
    
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
