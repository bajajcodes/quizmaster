//
//  UserPostView.swift
//  QuizMaster
//

import SwiftUI
import SDWebImageSwiftUI


struct UserPostView: View {
    var user: User?
    var rank: Int
    
    var body: some View {
        HStack(spacing: 12) {
            WebImage(url: user?.userProfileURL).placeholder {
                // MARK: Placeholder Imgae
                Image("NullProfile")
                    .resizable()
            }
            .resizable()
            .aspectRatio (contentMode: .fill)
            .frame(width: 80, height: 80)
            .clipShape(Circle())

            
            VStack(alignment: .leading, spacing: 6){
                Text(user?.username ?? "User Name Placeholder")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("Rank: \(rank)")
                    .font(.callout)
                    .lineLimit(3)
            }
            
        }.hAlign(.leading)
    }
}

#Preview {
    QuizPostView()
}
