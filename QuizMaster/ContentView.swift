//
//  ContentView.swift
//  QuizMaster
//

import SwiftUI
import Firebase

struct ContentView: View {
    
//    @AppStorage("log_status") var logStatus: Bool = false;

    init(){
        FirebaseApp.configure()
    }
    
    var body: some View {
        // MARK: redirecting user based on log_status
        LoginView()
        
    }
}

#Preview {
    ContentView()
}

struct ExploreQuizes: View {
    let quizInspirations = QuizInspiration.examples()

    var body: some View{
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
