//
//  View+Extension.swift
//  QuizMaster


import SwiftUI

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
