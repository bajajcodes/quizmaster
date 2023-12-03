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
    @State private var paginationDoc: QueryDocumentSnapshot?


    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVStack {
                    
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
                                
                                    ForEach(Array(allUsers.enumerated()), id: \.element.id) { (index, user) in
                                        UserPostView(user: user, rank: index+1)
                                            .onAppear{
                                                print("inside user post view on appear")
                                                // when last post appears, fetching new post. If There.
                                                if user.id == allUsers.last?.id && paginationDoc != nil {
                                                    print("Fetch new Post's inside leaderboard view")
                                                    Task{
                                                        await fetchAllUsers()
                                                    }
                                                }
                                            }
                                        
                                        Divider()
                                            .padding(.horizontal, -15)

                                    }
                                    .refreshable {
                // MARK: Refresh User Data
                isFetching = true
                self.allUsers = []
                await fetchAllUsers()
            }
                                
                                
                                              }
                    }
                    
                }
                
                
            }.navigationTitle("Leaderboard")
                .padding(.horizontal, 15)
                .refreshable {
// MARK: Refresh User Data
isFetching = true
self.allUsers = []
await fetchAllUsers()
}
            
            
            }
        // MARK: display error
        .alert(errorMessage, isPresented: $showError, actions: {
            
        }).task {
            guard allUsers.isEmpty else {return}
            // MARK: Initial Fetch
            await fetchAllUsers()
        }
        }
    
    func fetchAllUsers()async{
        do{

            var query: Query!
            if let paginationDoc {
                query = Firestore.firestore().collection("users")
                    .order(by: "score", descending: true)
                    .start(afterDocument: paginationDoc)
                    .limit(to: 5)
            }
            else {
                query = Firestore.firestore().collection("users")
                    .order(by: "score", descending: true)
                    .limit(to: 5)
            }
            let docs = try await query.getDocuments()
            let fetchedUsers = try docs.documents.compactMap{ doc -> User? in
                try doc.data(as: User.self)
            }
            await MainActor.run(body: {
                allUsers.append(contentsOf: fetchedUsers)
                paginationDoc = docs.documents.last
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
