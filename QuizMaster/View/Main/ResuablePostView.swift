//
//  ResuablePostView.swift
//  QuizMaster
//

import SwiftUI
import Firebase


struct ReuseablePostView: View {
    @Binding var allQuizPlayed: [QuizPlayedModel]
    // View Properties
    @State private var isFetching: Bool = true
    @State private var showError: Bool = false;
    @State private var errorMessage: String = "";

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            LazyVStack {
                
                if(isFetching){
                    ProgressView()
                        .padding(.top, 30)
                }else {
                    if(allQuizPlayed.isEmpty){
                        Text("No Quiz's Found")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    }else{
                        ForEach(allQuizPlayed) { play in
                            QuizPostView(quizPlayed: play)
                        }
                        .refreshable {
                            // MARK: Refresh User Data
                            isFetching = true
                            self.allQuizPlayed = []
                            await fetchAllQuiz()
                        }
                    }
                }
                
                
            }
            
        }
        // MARK: display error
        .alert(errorMessage, isPresented: $showError, actions: {
            
        })
        .task {
            // Fetching for one time
            guard allQuizPlayed.isEmpty else {return}
            await fetchAllQuiz()
        }
        
    }
    
    @ViewBuilder
    func QuizesViews()->some View {
        ForEach(allQuizPlayed){quiz in
            QuizPostView(quizPlayed: quiz)
        }
    }
    
    func fetchAllQuiz()async{
        do{
            guard let userID = Auth.auth().currentUser?.uid else {return}

            var query: Query!
            query = Firestore.firestore().collection("QuizPlayed")
                .whereField("userUID", isEqualTo: userID)
                .order(by: "publishedDate", descending: true)
                .limit(to: 20)
            let docs = try await query.getDocuments()
            let fetchedQuizs = try docs.documents.compactMap{ doc -> QuizPlayedModel? in
                try doc.data(as: QuizPlayedModel.self)
            }
            await MainActor.run(body: {
                allQuizPlayed = fetchedQuizs
                isFetching = false
            })
        }catch{
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
//            isLoading = false
        })
    }
}

#Preview {
    ContentView()
}

