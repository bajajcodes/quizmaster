//
//  ExploreQuizesView.swift
//  QuizMaster
//


import SwiftUI

struct ExploreQuizesView: View {
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
            .navigationTitle("All Quiz")
        }
    }
}

#Preview {
    ExploreQuizesView()
}
