//
//  LoginView.swift
//  QuizMaster
//

import SwiftUI
import Firebase

struct LoginView: View {
    // MARK: user details
    @State private var emailID: String = "";
    @State private var password: String  = "";
    // MARK: View Propeties
    @State private var createAccount: Bool = false;
    @State private var showError: Bool = false;
    @State private var errorMessage: String = "";
    @State var isLoading: Bool = false;
    // MARK: User Defaults
    @AppStorage("log_status") var logStatus: Bool = false;
    @AppStorage("user_profile_url") var profileUrl: URL?;
    @AppStorage("user_name") var userNameStored: String = "";
    @AppStorage("user_UID") var userUID: String = "";

    
    var body: some View {
        VStack(){
            Text("Let's Sign you in")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            Text("Welcome Back,\nYou have been missed")
                .font(.title3)
                .hAlign(.leading)
            
            VStack(spacing: 12){
                TextField("Email", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                Button("Reset Password?", action: resetPassword)
                    .font(.callout)
                    .tint(.black)
                    .hAlign(.trailing)
                    .fontWeight(.medium)
                
                Button(action: loginUser){
                    // MARK: Login Button
                    Text("Sign in")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(Color.black)
                    
                }.padding(.top, 10).disableWithOpactiy(emailID == "" || password == "")
            }
                HStack {
                    
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    
                    // MARK: Register Button
                    Button{
                        createAccount.toggle()
                    } label:{
                        Text("Register Now")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }.vAlign(.bottom).font(.callout)
            
            
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        // MARK: Register View VIA Sheets
        .fullScreenCover(isPresented: $createAccount){
            SignupView()
        }
        // MARK: display error
        .alert(errorMessage, isPresented: $showError, actions: {
            
        })
    }
    
    func loginUser(){
        isLoading = true
        closeAllKeyboard()
        Task{
            do{
               // By the help of Swift Concurrency Auth is done with single line
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User Found")
                try await fetchUser()
            }catch{
                await setError(error)
            }
        }
    }
    
    // MARK: Fetch user details from firestore
    func fetchUser()async throws{
            guard let userID = Auth.auth().currentUser?.uid else {return}
        let user = try await Firestore.firestore().collection("users").document(userID).getDocument(as: User.self)
                    // MARK: UI Updating Must be Run on Main Thread
                    await MainActor.run(body: {
                        // Setting user default's data and changing app auth-status
                        userNameStored =  user.userEmail
                        profileUrl = user.userProfileURL
                        print(user,  "user details")
                        self.userUID = userUID
                        logStatus = true
                    })
    }
    
    func resetPassword(){
        Task{
            do{
               // By the help of Swift Concurrency Auth is done with single line
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Password Reset Link Sent")
            }catch{
                await setError(error)
            }
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
    LoginView()
}

extension View {
    // MARK: Custom Border View with Padding
    func border(_ width: CGFloat,_ color: Color)-> some View{
        self.padding(.horizontal, 15).padding(.vertical, 10).background{
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .stroke(color, lineWidth: width)
        }
    }
    
    // MARK: Custom Fill View with Padding
    func fillView(_ color: Color)-> some View{
        self.padding(.horizontal, 15).padding(.vertical, 10).background{
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(color)
        }
    }
    
    // MARK: Disabling with Opactiy
    func disableWithOpactiy(_ condition: Bool)-> some View {
        self.disabled(condition).opacity(condition ? 0.6 : 1)
    }
    
    // MARK: Close All Active Keyboards
    func closeAllKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

