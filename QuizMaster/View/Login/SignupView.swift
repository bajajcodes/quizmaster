//
//  SignupView.swift
//  QuizMaster
//


import SwiftUI
//INFO: For Native SwiftUI Image Picker
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore


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
    @State private var showError: Bool = false;
    @State private var errorMessage: String = "";
    @State var isLoading: Bool = false;
    // MARK: View Propeties
    @Environment(\.dismiss) var dismiss
    // MARK: User Defaults
    @AppStorage("log_status") var logStatus: Bool = false;
    @AppStorage("user_profile_url") var profileUrl: URL?;
    @AppStorage("user_name") var userNameStored: String = "";
    @AppStorage("user_UID") var userUID: String = "";
    
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
                        dismiss()
                    } label:{
                        Text("Login Now")
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
        // MARK: display error
        .alert(errorMessage, isPresented: $showError, actions: {})
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
            
            
            Button (action:singupUser){
                // MARK: Signup Button
                Text("Sign up")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(Color.black)
                
            }
            .padding(.top, 10)
            .disableWithOpactiy(userName == "" || userBio == "" || emailID == "" || password == "" || userProfilePicData == nil)
            
        }

    }
    
    func singupUser(){
                        isLoading = true
        closeAllKeyboard()
        Task {
            do{
                // Step1: create firebase account
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                // Step2: upload profile picutre into firebase storage
                guard let userUID = Auth.auth().currentUser?.uid else {return}
                guard let imageData = userProfilePicData else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
                // Step3: downloading photo url
                let downloadUrl = try await storageRef.downloadURL()
                // Step4: creating a user firestore object
                let user = User(username: userName, userBio: userBio, userUID: userUID, userEmail: emailID, userProfileURL: downloadUrl)
                // Step5: saving user doc into firestore database
                try Firestore.firestore().collection("users").document(userUID).setData(from: user, completion: {
                    error in
                    if error == nil{
                        // MARK: Print saved or created user succesfully
                        print("User Created Succesfully")
                        userNameStored = userName
                        profileUrl = downloadUrl
                        self.userUID = userUID
                        logStatus = true
                    }
                })
            }catch{
                try await Auth.auth().currentUser?.delete()
                print(error, "is error message")
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
    SignupView()
}

