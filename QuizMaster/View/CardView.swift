//
//  CardView.swift
//  QuizMaster
//


import SwiftUI

struct CardView: View {
    var body: some View {
        Image("Medal")
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(alignment: .bottomTrailing, content: {
                Text("Quiz Title")
                    .bold()
                    .foregroundColor(Color.black)
                    .padding()
            })
    }
}

#Preview {
    CardView().padding()
}
