//
//  ContentView.swift
//  QuizMaster
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @AppStorage("log_status") var logStatus: Bool = false;

    init(){
        FirebaseApp.configure()
    }
    
    var body: some View {
        // MARK: redirecting user based on log_status
        if logStatus {
            Text("Logged in")
        }else{
            LoginView()
        }
        
    }
}

#Preview {
    ContentView()
}

