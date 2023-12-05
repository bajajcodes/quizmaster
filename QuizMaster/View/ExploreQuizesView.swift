//
//  ExploreQuizesView.swift
//  QuizMaster
//


import SwiftUI
import Firebase
import FirebaseAuth
import Foundation


import SwiftUI
import Firebase
import FirebaseAuth

struct ExploreQuizesView: View {
    let quizCategory: QuizCategoryModel

    // MARK: My Quiz's Data
    @State private var allQuiz: [QuizInfoModel]?
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var startQuiz: Bool = true;


    var body: some View {
                
        NavigationView {
            ScrollView {
                LazyVStack() {
                    if let quizInspirations = allQuiz {
                        ScrollView {
                            LazyVStack() {
                                ForEach(quizInspirations) { quizInspiration in
                                    NavigationLink(destination: Home(quizInspiration: quizInspiration, quizCategory: quizCategory )) {
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
            }
            .refreshable {
                // MARK: Refresh Quiz Data
                self.allQuiz = nil
                await fetchAllQuizData()
            }
            
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
//            try await Auth.auth().signInAnonymously()
        // MARK: id cannot be null
            let quizes = try await Firestore.firestore().collection("Quiz2").document(quizCategory.id ?? "NA").collection("quizes").getDocuments().documents.compactMap {
                try $0.data(as: QuizInfoModel.self)
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
        ContentView()
    }
}

#Preview {
    ContentView()
}
