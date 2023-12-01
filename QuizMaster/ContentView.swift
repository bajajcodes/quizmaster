//
//  ContentView.swift
//  QuizMaster
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some View {
        QuizInspirationCardView(quizInspiration: QuizInspiration.exampleCSharp() ).preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
