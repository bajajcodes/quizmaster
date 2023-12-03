//
//  MainView.swift
//  QuizMaster
//

import SwiftUI

struct MainView: View {
    var body: some View {
        // MARK: TabView with quizes and profile tab
        TabView{
            ExploreQuizesView()
                .tabItem{
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("All Quiz")
                }
            
            ProfileView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Profile")
                }
            
            LeaderboardView()
                .tabItem{
                    Image(systemName: "trophy")
                    Text("Leaderboard")
                }
        }.tint(Color.oPink)
    }
}

#Preview {
    MainView()
}
