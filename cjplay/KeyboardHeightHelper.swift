//
//  KeyboardHeightHelper.swift
//  cjplay
//
//  Created by CJ Pais on 2/2/21.
//  Copyright © 2021 CJ Pais. All rights reserved.
//

import UIKit
import Foundation

class KeyboardHeightHelper: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        self.listenForKeyboardNotifications()
    }

    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
                                                guard let userInfo = notification.userInfo,
                                                    let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                                                
                                                self.keyboardHeight = keyboardRect.height
            NotificationCenter.default.post(Notification(name: .init(rawValue: "textUpdate"), object: nil))
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
                                                self.keyboardHeight = 0
            NotificationCenter.default.post(Notification(name: .init(rawValue: "textUpdate"), object: nil))
        }
    }
}


