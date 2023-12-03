//
//  ResuableLeaderboardUserPostView.swift
//  QuizMaster
//


import SwiftUI
import Firebase


struct LeaderboardUserPostView: View {
    @Binding var allUsers: [User]


    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            LazyVStack {
                QuizesViews()
            }
            
        }.padding(.horizontal, 15)
        
    }
    
    @ViewBuilder
    func QuizesViews()->some View {
        ForEach(Array(allUsers.enumerated()), id: \.element.id) { (index, user) in
            UserPostView(user: user, rank: index+1)
        }
    }
    

    

}

#Preview {
    ContentView()
}
