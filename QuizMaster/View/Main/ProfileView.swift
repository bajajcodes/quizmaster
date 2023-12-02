//
//  ProfileView.swift
//  QuizMaster
//


import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    
    // MARK: My Profile Data
    @State private var myProfile: User?
    @State private var showError: Bool = false;
    @State private var errorMessage: String = "";
    @State var isLoading: Bool = false;
    @AppStorage("log_status") var logStatus: Bool = false
    

    var body: some View {
        NavigationStack{
            VStack{
                if let myProfile {
                    ReusableProfileContentView(user: myProfile)
                        .refreshable {
                            // MARK: Refresh User Data
                            self.myProfile = nil
                            await fetchUserData()
                        }
                }else {
                    ProgressView()
                }
            }
            .navigationTitle ("My Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        // MARK: Actions
                        // 1. Logout
                        
                        Button("Logout", role: .destructive, action: logoutUser)
                        
                    } label: {
                        Image (systemName: "ellipsis")
                            .rotationEffect(.init(degrees: 90))
                            .tint(.black)
                            .scaleEffect (0.8)
                    }
                }
            }
        }
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        // MARK: display error
        .alert(errorMessage, isPresented: $showError, actions: {
            
        }).task {
            // Limiting to intiial fetch because tasks is alternative to onAppear
            // Whenever tab is changed or reopened it will be called like onAppear
            if myProfile != nil {return}
            // MARK: Initial Fetch
            await fetchUserData()
        }
    }
    
    func fetchUserData()async{
        isLoading = true
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        guard let user = try? await Firestore.firestore().collection("users").document(userID).getDocument(as: User.self) else {return}
        
                await MainActor.run(body: {
                    myProfile = user
                })
    }
    
    func logoutUser(){
        try? Auth.auth().signOut()
        logStatus = false
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
    ProfileView()
}
