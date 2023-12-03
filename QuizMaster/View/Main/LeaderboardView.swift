//
//  LeaderboardView.swift
//  QuizMaster
//

import SwiftUI
import Firebase


struct LeaderboardView: View {
    // View Properties
    @State private var allUsers: [User] = []
    @State private var isFetching: Bool = true
    @State private var showError: Bool = false;
    @State private var errorMessage: String = "";

    var body: some View {
        NavigationView{
            VStack{
                
                
                if isFetching {
                    ProgressView()
                        .padding(.top, 30)
                }else {
                    if allUsers.isEmpty {
                        Text("No User's Found")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    }else {
                        LeaderboardUserPostView(allUsers: $allUsers)
                        .refreshable {
                            // MARK: Refresh User Data
                            isFetching = true
                            self.allUsers = []
                            await fetchAllUsers()
                        }
                    }
                }
                
            }.navigationTitle("Leaderboard")
            }
        // MARK: display error
        .alert(errorMessage, isPresented: $showError, actions: {
            
        }).task {
            // Limiting to intiial fetch because tasks is alternative to onAppear
            // Whenever tab is changed or reopened it will be called like onAppear
            guard allUsers.isEmpty else {return}
            // MARK: Initial Fetch
            await fetchAllUsers()
        }
        }
    
    func fetchAllUsers()async{
        do{
//            guard let userID = Auth.auth().currentUser?.uid else {return}

            var query: Query!
            query = Firestore.firestore().collection("users")
                .order(by: "score", descending: true)
                .limit(to: 20)
            let docs = try await query.getDocuments()
            let fetchedUsers = try docs.documents.compactMap{ doc -> User? in
                try doc.data(as: User.self)
            }
            await MainActor.run(body: {
                allUsers = fetchedUsers
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
