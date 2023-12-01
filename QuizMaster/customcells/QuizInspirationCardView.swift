//
//  QuizInspirationCardView.swift
//  QuizMaster
//


import SwiftUI

struct QuizInspirationCardView: View {
    let quizInspiration: QuizInspiration
    let padding: CGFloat = 10
    
    var body: some View {
        Image(quizInspiration.imageName)
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(alignment: .bottomTrailing, content: {
                Text(quizInspiration.name)
                    .bold()
                    .foregroundColor(Color.black)
                    .padding()
            })
    }
}

#Preview {
    QuizInspirationCardView(quizInspiration: QuizInspiration.exampleSwiftUI()).padding()
}
