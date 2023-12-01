//
//  ContentView.swift
//  QuizMaster
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var quizInspirations = QuizInspiration.examples()

    init(){
        FirebaseApp.configure()
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack(spacing: 10){
                    ForEach(quizInspirations){quizInspiration in
                        NavigationLink(destination: Home(quizInspiration: quizInspiration)){
                            QuizInspirationCardView(quizInspiration: quizInspiration)
                            .frame(height: 150)
                        }
                    }
                }.padding()
            }
            .navigationTitle("Quiz Inspirations")
        }
    }
}

#Preview {
    ContentView()
}
