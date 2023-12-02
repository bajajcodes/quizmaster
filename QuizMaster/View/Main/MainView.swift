//
//  MainView.swift
//  QuizMaster
//

import SwiftUI

struct MainView: View {
    var body: some View {
        // MARK: TabView with quizes and profile tab
        TabView{
            Text("All Quiz View")
                .tabItem{
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("All Quiz")
                }
            
            Text("Profile View")
                .tabItem{
                    Image(systemName: "gear")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainView()
}
