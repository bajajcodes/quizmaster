//
//  QuestionsView.swift
//  QuizMaster
//

import SwiftUI
import FirebaseFirestore

struct QuestionsView: View {
    let quizInspiration: QuizInspiration
    var quizInfo: Info
    @State var quizQuestions: [Question];
    var onFinish: ()->()
    
    @Environment(\.dismiss) private var dismiss

    @State private var progress: CGFloat = 0
    @State private var currentIndex: Int = 0
    @State private var score: CGFloat = 0
    @State private var showScoreCardView: Bool = false
    
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
            
            CustomButton(title: currentIndex == (quizQuestions.count - 1) ? "Finish" : "Next Question", onClick: {
                if currentIndex == (quizQuestions.count - 1){
                    // Presenting Score Card View
                    showScoreCardView.toggle()
                }
                else{
                    withAnimation(.easeInOut){
                        currentIndex += 1
                        progress = CGFloat(currentIndex) / CGFloat(quizQuestions.count - 1)
                    }
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
        .fullScreenCover(isPresented: $showScoreCardView) {
            // display score in 100%
            ScoreCardView(score: score / CGFloat(quizQuestions.count) * 100, quizInspiration: quizInspiration){
                dismiss()
                onFinish()
            }
        }
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
                    // Displaying Correct and Wrong answers, after user has tapped any one of the options
                    ZStack{
                        OptionView(option, .gray)
                            .opacity(question.answer == option && question.tappedAnswer != "" ? 0 : 1)
                        OptionView(option, .green)
                            .opacity(question.answer == option && question.tappedAnswer != "" ? 1 : 0)
                        OptionView(option, .red)
                            .opacity(question.tappedAnswer == option && question.tappedAnswer != question.answer ? 1 : 0)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // -Disabling Tap if already Answer was Selected
                        guard quizQuestions[currentIndex].tappedAnswer == "" else{return}
                        withAnimation(.easeInOut){
                            quizQuestions[currentIndex].tappedAnswer = option
                        }
                        if question.answer == option {
                            score += 1.0
                        }
                    }
                }
            }.padding(.vertical, 10)}.padding(15).hAlign(.center).background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.white)
            }.padding(.horizontal,15)
    }
    
    // OptionView
    @ViewBuilder
    func OptionView(_ option: String, _ tint: Color)-> some View {
        Text(option).foregroundColor(tint).padding(.horizontal, 15).padding(.vertical, 20).hAlign(.leading).background{
            RoundedRectangle(cornerRadius: 12, style: .continuous).fill(tint.opacity(0.15)).background{
                RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(tint.opacity(tint == .gray ? 0.15 : 1), lineWidth: 2)
            }
        }
    }
    
    
}

// MARK: Score Card View
struct ScoreCardView: View {
    var score: CGFloat
    let quizInspiration: QuizInspiration
    // move to home screen
    var onDismiss: ()->()
    @Environment(\.dismiss) private var dismiss
    var body: some View{
        VStack{
            VStack(spacing: 15){
                Text("Result of Your Exercise")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    Text("Congratulations! You\n have score")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    //  Removing Floating Points
                    Text(String(format: "%.0f", score) + "%")
                        .font(.title.bold())
                            .padding(.bottom, 10)
                    
                    Image("Medal").resizable().aspectRatio(contentMode: .fit).frame(height: 220)
                }.foregroundColor(.black).padding(.horizontal, 15).padding(.vertical, 20).hAlign(.center).background{
                    RoundedRectangle(cornerRadius: 25, style: .continuous).fill(.white)
                }
                
            }.vAlign(.center)
            
            CustomButton(title: "Back To Home", onClick: {
                Firestore.firestore().collection("Quiz").document(quizInspiration.quizCollectionIDName).updateData([
                    "peopleAttended": FieldValue.increment(1.0)])
                onDismiss()
                dismiss()
            })
        }.padding(15).background {
            Color("BG").ignoresSafeArea()
        }
    }}

#Preview {
    ContentView()
}
