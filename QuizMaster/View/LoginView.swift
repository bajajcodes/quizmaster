//
//  LoginView.swift
//  QuizMaster
//


import SwiftUI
//INFO: For Native SwiftUI Image Picker
import PhotosUI
import Firebase

struct LoginView: View {
    // MARK: user details
    @State private var emailID: String = "";
    @State private var password: String  = "";
    // MARK: View Propeties
    @State private var createAccount: Bool = false;
    @State private var showError: Bool = false;
    @State private var errorMessage: String = "";
    
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
                    
                }.padding(.top, 10)
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
        // MARK: Register View VIA Sheets
        .fullScreenCover(isPresented: $createAccount){
            SignupView()
        }
        // MARK: display error
        .alert(errorMessage, isPresented: $showError, actions: {
            
        })
    }
    
    func loginUser(){
        Task{
            do{
               // By the help of Swift Concurrency Auth is done with single line
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User Signed In")
            }catch{
                await setError(error)
            }
        }
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
}


// MARK: Signup View
struct SignupView: View {
    // MARK: user details
    @State private var emailID: String = "";
    @State private var password: String  = "";
    @State private var userName: String = "";
    @State private var userBio: String = "";
    @State private var userProfilePicData: Data?;
    @State private var showImagePicker: Bool = false;
    @State private var photoItem: PhotosPickerItem?;
    // MARK: View Propeties
    @Environment(\.dismiss) var dimiss
    
    var body: some View {
        VStack(){
            Text("Let's Register\nAccount")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            Text("Hello User,\nHave a wondeful journey")
                .font(.title3)
                .hAlign(.leading)
            
            // MARK: For Smaller Size Optimization
            ViewThatFits {
                ScrollView(.vertical, showsIndicators: false){
                    HelperView()
                }
                HelperView()
            }
            
                HStack {
                    
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    // MARK: Register Button
                    Button{
                        dimiss()
                    } label:{
                        Text("Login Now")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }.vAlign(.bottom).font(.callout)
            
            
        }
        .vAlign(.top)
        .padding(15)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        // TODO: Refactor the Depracated Handler
        .onChange(of: photoItem){newValue in
            // MARK: Extracting UI Image From PhotoImage
            if let newValue{
                Task{
                    do{
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else {return}
                        // MARK: UI Must be updated on Main Thread
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    }catch{}
                }
            }
        }
    }
    
    @ViewBuilder
    func HelperView() -> some View {
        VStack(spacing: 12){
            
            ZStack{
                if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)

                }else{
                    Image("NullProfile")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .padding(.top, 25)
            .onTapGesture {
                showImagePicker.toggle()
            }

            
            TextField("UserName", text: $userName)
                .textContentType(.name)
                .border(1, .gray.opacity(0.5))
            
            TextField("Email", text: $emailID)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("About You", text: $userBio, axis: .vertical)
                .frame(minHeight:100, alignment: .top)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            SecureField("Password", text: $password)
                .textContentType(.password)
                .border(1, .gray.opacity(0.5))
            
            
            Button {
                
            } label:{
                // MARK: Login Button
                Text("Sign up")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(Color.black)
                
            }.padding(.top, 10)
            
        }

    }

}

