//
//  ResuablePostView.swift
//  QuizMaster
//

import SwiftUI
import SDWebImageSwiftUI


struct ResuablePostView: View {
    var quizPlayed: QuizPlayedModel?
    var body: some View {
        
        ScrollView{
            
            LazyVStack {
                
                HStack(spacing: 12) {
                    WebImage(url: quizPlayed?.imageURL).placeholder {
                        // MARK: Placeholder Imgae
                        Image("NullQuiz")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio (contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape (Circle())

                    
                    VStack(alignment: .leading, spacing: 6){
                        Text(quizPlayed?.title ?? "Quiz Title Placeholder")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(quizPlayed?.description ?? "Quiz Description Placeholder")
                            .font(.caption)
                            .lineLimit(3)
                            .foregroundColor(.gray)
                    }
                    
                }.hAlign(.leading)
                
            }
            
        }.padding(15)
        
    }
}

#Preview {
    ResuablePostView()
}

