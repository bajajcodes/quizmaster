//
//  QuizesCategoriesView.swift
//  QuizMaster

import SwiftUI
import Firebase
import SDWebImageSwiftUI


struct QuizesCategoriesView: View {
    
    @State private var allQuizCategories: [QuizCategoryModel]?
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    private var data: [Int] = Array(1...20)
    private let colors: [Color] = [.red, .green, .blue]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let quizCategories = allQuizCategories {
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(quizCategories){quizCategory in
                            NavigationLink(destination: ExploreQuizesView(quizCategory: quizCategory)){
                                ZStack {
                                    
                                    WebImage(url: quizCategory.imageURL).placeholder {
                                        // MARK: Placeholder Imgae
                                        Image("NullProfile")
                                            .resizable()
                                    }
                                    .resizable()
                                    .aspectRatio (contentMode: .fill)
                                    .frame(width: 170, height: 170)
                                    .cornerRadius(30)
                                    .foregroundColor(.white)
                                    
                                    Text("Programming")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                        .font(.callout)
                                        .padding()
                                   
                                }
                            }
                        }
                    }
                }
                else {
                    VStack(spacing: 4) {
                        ProgressView()
                        Text("Please Wait")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("All Quiz")
            .refreshable {
                // MARK: Refresh Quiz Data
                self.allQuizCategories = nil
                await fetchAllQuizCategories()
            }
            
        }
        .task {
            await fetchAllQuizCategories()
        }
        .alert("Error", isPresented: $showError, actions: {
            EmptyView()
        })
        
    }
    
    func fetchAllQuizCategories() async {
        do {
            let quizCategories = try await Firestore.firestore().collection("Quiz2").getDocuments().documents.compactMap {
                try $0.data(as: QuizCategoryModel.self)
            }
            
            await MainActor.run {
                allQuizCategories = quizCategories
            }
            
        } catch {
            await setError(error)
        }
    }

    
    // MARK: Display error via Alert
    func setError(_ error: Error) async {
        await MainActor.run {
            print(error)
            errorMessage = error.localizedDescription
            showError.toggle()
        }
    }
}

#Preview {
    QuizesCategoriesView()
}
