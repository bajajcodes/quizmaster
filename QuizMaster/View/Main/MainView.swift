//
//  MainView.swift
//  QuizMaster
//

import SwiftUI

struct MainView: View {
    @State private var currentTab: Tab = .Explore
    
    private enum Tab: String {
        case Explore, Profile, Leaderboard
    }

    var body: some View {
        // MARK: TabView with quizes and profile tab
        TabView(selection: $currentTab){
            QuizesCategoriesView()
                .tabItem{
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("All Quiz")
                }.tag(Tab.Explore)
            
            ProfileView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Profile")
                }.tag(Tab.Profile)
            
            LeaderboardView()
                .tabItem{
                    Image(systemName: "trophy")
                    Text("Leaderboard")
                }.tag(Tab.Leaderboard)
            
        }.tint(Color.oPink)
    }
    
}



#Preview {
    MainView()
}
