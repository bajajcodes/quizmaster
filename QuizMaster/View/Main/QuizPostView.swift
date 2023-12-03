//
//  QuizPostView.swift
//  QuizMaster
//

import SwiftUI
import SDWebImageSwiftUI


struct QuizPostView: View {
    var quizPlayed: QuizPlayedModel?
    
    var body: some View {
        HStack(spacing: 12) {
            WebImage(url: quizPlayed?.imageURL).placeholder {
                // MARK: Placeholder Imgae
                Image("NullQuiz")
                    .resizable()
            }
            .resizable()
            .aspectRatio (contentMode: .fill)
            .frame(width: 80, height: 80)
            .clipShape(Rectangle())

            
            VStack(alignment: .leading, spacing: 6){
                Text(quizPlayed?.title ?? "Quiz Title Placeholder")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("Score: " + String(format: "%.2f%%", quizPlayed?.score ?? 0.0))
                    .font(.callout)
                    .lineLimit(3)
            }
            
        }.hAlign(.leading)
    }
}

#Preview {
    QuizPostView()
}
