//
//  Home.swift
//  QuizMaster
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Home: View {
    @State private var quizInfo: Info?
    @State private var quizQuestions: [Question] = [];
    @AppStorage("log_status") private var logStatus: Bool = false;
    var body: some View {
        if let info = quizInfo {
            Text(info.title)
        }else{
            VStack(spacing: 4){
                ProgressView()
                Text("Please Wait")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }.task {
                do{
                    try await fetchData()
                }catch{
                    print(error)
                }
            }
        }
    }
    
    func fetchData()async throws{
        try await logInUserAnonymous()
        let info = try await Firestore.firestore().collection("Quiz").document("Info").getDocument().data(as: Info.self)
        let questions = try await Firestore.firestore().collection("Quiz").document("Info").collection("Questions").getDocuments().documents.compactMap{try $0.data(as: Question.self
        )}
        
        //UI must be updated on Main Thread
        await MainActor.run(body: {
            quizInfo = info;
            quizQuestions = questions;
        })
    }
    
    func logInUserAnonymous()async throws {
        if !logStatus {
            try await Auth.auth().signInAnonymously();
        }
    }
}

#Preview {
    Home()
}

