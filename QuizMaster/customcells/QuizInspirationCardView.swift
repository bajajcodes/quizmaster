//
//  QuizInspirationCardView.swift
//  QuizMaster
//


import SwiftUI
import SDWebImageSwiftUI


struct QuizInspirationCardView: View {
    let quizInspiration: QuizInspiration
    let padding: CGFloat = 10
    
    var body: some View {
        WebImage(url: quizInspiration.imageURL).placeholder {
            // MARK: Placeholder Imgae
            Image("NullQuiz")
                .resizable()
        }
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(alignment: .bottomTrailing, content: {
                Text(quizInspiration.title)
                    .bold()
                    .font(.title2)
                    .foregroundColor(Color.black)
                    .padding()
            })
    }
}

#Preview {
    ContentView()
}
