//
//  LoginView.swift
//  QuizMaster
//


import SwiftUI

struct LoginView: View {
    // MARK: user details
    @State private var emailID: String = "";
    @State private var password: String  = "";
    
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
                
                Button("Reset Password?", action: {})
                    .font(.callout)
                    .tint(.black)
                    .hAlign(.trailing)
                    .fontWeight(.medium)
                
                Button {
                    
                } label:{
                    // MARK: Login Button
                    Text("Sign in")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(Color.black)
                        
                }.padding(.top, 10)
                
                HStack {
                    
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    
                    // MARK: Register Button
                    Button{
                        
                    } label:{
                        Text("Register Now")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }.vAlign(.bottom).font(.callout)
            }
            
        }.vAlign(.top).padding(15)
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
