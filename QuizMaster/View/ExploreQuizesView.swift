//
//  ExploreQuizesView.swift
//  QuizMaster
//


import SwiftUI
import Firebase
import FirebaseAuth

import SwiftUI
import Firebase
import FirebaseAuth

struct ExploreQuizesView: View {
    // MARK: My Quiz's Data
    @State private var allQuiz: [QuizInspiration]?
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var startQuiz: Bool = true;


    var body: some View {
                
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    if let quizInspirations = allQuiz {
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(quizInspirations) { quizInspiration in
                                    NavigationLink(destination: Home(quizInspiration: quizInspiration)) {
                                        QuizInspirationCardView(quizInspiration: quizInspiration)
                                    }
                                }
                            }
                            .padding()
                            .refreshable {
                                // MARK: Refresh Quiz Data
                                self.allQuiz = nil
                                await fetchAllQuizData()
                            }
                        }
                        
                    } else {
                        VStack(spacing: 4) {
                            ProgressView()
                            Text("Please Wait")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("All Quiz")
            
        }
        .task {
            await fetchAllQuizData()
        }
        .alert("Error", isPresented: $showError, actions: {
            EmptyView()
        })
    }

    func fetchAllQuizData() async {
        do {
            try await Auth.auth().signInAnonymously()
            let quizes = try await Firestore.firestore().collection("Quiz").getDocuments().documents.compactMap {
                try $0.data(as: QuizInspiration.self)
            }

            await MainActor.run {
                allQuiz = quizes
            }
        } catch {
            await setError(error)
        }
    }

    // MARK: Display error via Alert
    func setError(_ error: Error) async {
        await MainActor.run {
            print(error)
            errorMessage = error.localizedDescription
            showError.toggle()
        }
    }
}

struct ExploreQuizesView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreQuizesView()
    }
}

#Preview {
    ExploreQuizesView()
}
