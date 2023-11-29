//
//  QuestionsView.swift
//  QuizMaster
//

import SwiftUI

struct QuestionsView: View {
    var quizInfo: Info;
    var quizQuestions: [Question];
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 0
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 15){
            Button{
                dismiss()
            }
        label:{
            Image(systemName: "xmark")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }.hAlign(.leading)
            
            Text(quizInfo.title).font(.title).fontWeight(.semibold).foregroundColor(.white)
            
            GeometryReader{
                let size = $0.size
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.black.opacity (0.2))
                    Rectangle()
                        .fill(Color("Progress"))
                        .frame(width: progress * size.width, alignment: .leading)
                }
                .clipShape(Capsule())
            }
            .frame(height: 20)
            .padding (.top,5)
            
            // - Questions
            GeometryReader{_ in
                
                ForEach(quizQuestions.indices, id: \.self) { index in
                    // Using transition for moving forth and between instead of using tabview

                    if currentIndex == index {
                        // view enters from left and leaves towards right
                        QuestionView(quizQuestions[currentIndex])
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                    // Add other views or logic related to each element here
                }

            }.padding(.horizontal, -15).padding(.vertical, 15)
            
            CustomButton(title: "Next Question", onClick: {
                withAnimation(.easeInOut){
                    currentIndex += 1
                }
            })
            
        }
        .padding(15)
        .hAlign(.center).vAlign(.top)
        .background {
            Color("BG")
                .ignoresSafeArea()
        }
        /// This View is going to be Dark Since our background is Dark
        .environment(\.colorScheme, .dark)
    }
    
    // Question View
    @ViewBuilder
    func QuestionView(_ question: Question)-> some View{
//        RoundedRectangle(cornerRadius: 20, style: .continuous)
//            .fill(.white).padding(.horizontal, 15)
        
        VStack(alignment: .leading, spacing: 15) {
            Text("Question\(currentIndex + 1)/\(quizQuestions.count)")
                .font(.callout)
                .foregroundColor(.gray)
                .hAlign(.leading)
            Text (question.question)
                .font (.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            VStack(spacing: 12){
                ForEach(question.options,id: \.self) {option in
                    OptionView(option, .gray)
                }
            }}.padding(15).hAlign(.center).background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.white)
            }.padding(.horizontal,15)
    }
    
    // OptionView
    @ViewBuilder
    func OptionView(_ option: String, _ tint: Color)-> some View {
        Text(option).foregroundColor(tint).padding(.horizontal, 15).padding(.vertical, 20).hAlign(.leading).background{
            RoundedRectangle(cornerRadius: 12, style: .continuous).fill(tint.opacity(0.15)).background{
                RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(tint, lineWidth: 2)
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
