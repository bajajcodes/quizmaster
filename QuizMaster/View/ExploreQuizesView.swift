//
//  ExploreQuizesView.swift
//  QuizMaster
//


import SwiftUI
import Firebase
import FirebaseAuth

struct ExploreQuizesView: View {
    // MARK: My Quiz's Data
    @State private var allQuiz: [QuizInspiration]?
    @State private var showError: Bool = false;
    @State private var errorMessage: String = "";
    @State var isLoading: Bool = false;

    var body: some View{
        NavigationView{
            ScrollView{
                LazyVStack(spacing: 10){
                    
            if let quizInspirations = allQuiz {
                NavigationView{
                    ScrollView{
                        LazyVStack(spacing: 10){
                            ForEach(quizInspirations){quizInspiration in
                                NavigationLink(destination: Home(quizInspiration: quizInspiration)){
                                    QuizInspirationCardView(quizInspiration: quizInspiration)
                                    .frame(height: 150)
                                }
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                            // MARK: Refresh Quiz Data
                            self.allQuiz = nil
                            await fetchAllQuizData()
                    }
                    .navigationTitle("All Quiz")
                }
            }
            else {
                VStack(spacing: 4){
                    ProgressView()
                    Text("Please Wait")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
                    
                    
                }.padding()
            }
        }
        .navigationTitle("All Quiz")
        .task {
                await fetchAllQuizData()
        }        
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        // MARK: display error
        .alert(errorMessage, isPresented: $showError, actions: {
            
        })
        
    }
    
    
    func fetchAllQuizData()async{
        do {
            isLoading  = true
//            guard let userID = Auth.auth().currentUser?.uid else {return}
            try await Auth.auth().signInAnonymously();
            let quizes = try await Firestore.firestore().collection("Quiz").getDocuments().documents.compactMap{try $0.data(as: QuizInspiration.self)}
            
                    await MainActor.run(body: {
                        allQuiz = quizes
                    })
        }
        catch{
            await setError(error)
        }
    }
    
    // MARK: Diaply error via Alert
    func setError(_ error: Error)async{
        // MARK: UI must be updated on Main Thread
        await MainActor.run(body: {
            print(error)
            errorMessage = error.localizedDescription;
            showError.toggle()
            isLoading = false
        })
    }
}

#Preview {
    ExploreQuizesView()
}
