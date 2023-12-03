//
//  ReusableProfileContentView.swift
//  QuizMaster
//

import SwiftUI
import SDWebImageSwiftUI

struct ReusableProfileContentView: View {
    @State private var allQuizPlayed: [QuizPlayedModel] = []
    var user: User?;
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack{
                HStack(spacing: 12) {
                    WebImage(url: user?.userProfileURL).placeholder {
                        // MARK: Placeholder Imgae
                        Image("NullProfile")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio (contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape (Circle())
                    
                    VStack(alignment: .leading, spacing: 6){
                        Text(user?.username ?? "UserName Placeholder")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Total Score: " + String(format: "%.2f%", user?.score ?? 0.0))
                            .font(.callout)
                            .lineLimit(3)
                        
                        Text(user?.userBio ?? "UserBio Placeholder")
                            .font(.caption)
                            .lineLimit(3)
                            .foregroundColor(.gray)
                    }

                }.hAlign(.leading)
                
                Text("Quiz 's")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .hAlign(.leading)
                    .padding(.vertical, 15)
                
                ReuseablePostView(allQuizPlayed: $allQuizPlayed)
                
                
            }
        }.padding(15)
    }
}

#Preview {
    ReusableProfileContentView()
}
