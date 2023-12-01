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
    @State private var startQuiz: Bool = false;
    @AppStorage("log_status") private var logStatus: Bool = false;
    
    var body: some View {
        if let info = quizInfo {
            VStack(spacing: 10){
                Text(info.title).font(.title).fontWeight(.semibold).hAlign(.leading)
                /// - Custom Label
                
                CustomLabel("list.bullet.rectangle.portrait", "\(quizQuestions.count)", "Multiple Choice Question").padding(.top, 20)
                
                CustomLabel("person", "\(info.peopleAttended)", "Attended the exercise").padding(.top, 5)
                
                Divider().padding(.horizontal, -15).padding(.top, 15)
                
                if(!info.rules.isEmpty){
                    RulesView(info.rules)
                }
            
                
                CustomButton(title: "Start Test", onClick: {
                    startQuiz.toggle()
                }).vAlign(.bottom)
                
            }.padding(15).vAlign(.top).fullScreenCover(isPresented: $startQuiz){
                QuestionsView(quizInfo: info, quizQuestions: quizQuestions){
                    // user has succesfully finished the quiz thus update the BE and UI
                    quizInfo?.peopleAttended += 1
                }
            }
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
    
    // - Rules View
    @ViewBuilder
    func RulesView(_ rules: [String]) -> some View{
        VStack(alignment: .leading, spacing: 15){
            Text("Before you start")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 12)
            
            ForEach(rules, id: \.self){rule in
                HStack(alignment: .top, spacing: 10){
                    Circle().fill(.black).frame(width: 8, height: 8).offset(y: 6)
                    Text(rule).font(.callout).lineLimit(3)
                }
            }
        }
    }
    
    /// - Custom Label
    @ViewBuilder
    func CustomLabel(_ image: String, _ title: String, _ subTitle: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: image)
                .font(.title3)
                .frame(width: 45, height: 45)
                .background {
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                        .padding(-1)
                        .background {
                            Circle().stroke(Color("BG"), lineWidth: 1)
                        }
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("BG"))

                Text(subTitle)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }.hAlign(.leading)
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

// MARK: View Extensions
/// - Useful for moving views btw HStack and VStack

extension View{
    func hAlign(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
}

/// Making it Reusable
struct CustomButton: View{
    var title: String
    var onClick: ()->()
    
    var body: some View{
        Button {
            onClick()
        } label: {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .hAlign(.center)
                .padding(.top, 15)
                .padding(.bottom, 10)
                .foregroundColor(.white)
                .background {
                    Rectangle()
                        .fill(Color("OPink"))
                        .ignoresSafeArea()
                }
        }
        /// - Removing Padding
        .padding([.bottom,.horizontal], -15)
    }
}
