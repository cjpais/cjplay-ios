//
//  TextView.swift
//  cjplay
//
//  Created by CJ Pais on 4/4/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI
import Foundation

struct TextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    @Binding var height: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.font = UIFont.systemFont(ofSize: 16)
        
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = true
        textView.textColor = .white
        textView.backgroundColor = .clear
        
        textView.becomeFirstResponder()
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.delegate = context.coordinator
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            print(textView.contentSize)
            parent.height = textView.contentSize.height + 16
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            
            if parent.height != textView.contentSize.height + 10 {
                // notify the view size is changing
                NotificationCenter.default.post(Notification(name: .init(rawValue: "textUpdate"), object: nil))
            }
            
            parent.height = textView.contentSize.height + 10
        }
    }
}
