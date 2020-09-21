//
//  KeyboardAwareModifier.swift
//  cjplay
//
//  Created by CJ Pais on 6/30/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI
import Combine

struct KeyboardAwareModifier: ViewModifier {
    
    @State private var keyboardHeight: CGFloat = 0
    
    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        let keyboardWillShowPublisher = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map { $0.cgRectValue.height }
        
        let keyboardWillHidePublisher = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return Publishers.Merge(keyboardWillShowPublisher, keyboardWillHidePublisher)
            .eraseToAnyPublisher()
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardHeightPublisher) { keyboardHeight = $0 }
    }
}

extension View {
    func KeyboardAwarePadding() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAwareModifier())
    }
}
