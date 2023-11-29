//
//  Home.swift
//  QuizMaster
//

import SwiftUI

struct Home: View {
    @State private var quizInfo: Info?
    var body: some View {
        if let info = quizInfo {
            
        }else{
            VStack(spacing: 4){
                ProgressView()
                Text("Please Wait")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    Home()
}

