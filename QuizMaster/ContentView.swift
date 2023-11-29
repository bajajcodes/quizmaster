//
//  ContentView.swift
//  QuizMaster
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some View {
        Home().preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
