//
//  CJState.swift
//  cjplay
//
//  Created by CJ Pais on 3/28/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum Mode: String, CaseIterable, Identifiable {
    case stream
    case dev
    
    var id: Mode {
        self
    }
    
    var string: String {
        rawValue.prefix(1).uppercased() + rawValue.dropFirst()
    }
    
}

class CJState: ObservableObject {
    @Published var count: Int = 0
    @Published var note: String = ""
    @Published var textHeight: CGFloat = 0.0
    @Published var mode: Mode = .stream
    
    private var api_path: String {
        let s: String
        
        switch mode {
        case .stream:
            s = note_api_path
        case .dev:
            s = note_api_path_dev
        }
        
        return s
    }

    func resetNote() {
        self.note = ""
    }
    
    func sendNote() {
        
        if self.note != "" {
            if let url = URL(string: "\(ip_addr)\(api_path)") {
                let postString = Date().toString() + ": " + self.note
                let postData = postString.data(using: String.Encoding.utf8)
                var req = URLRequest(url: url)
                req.setValue("text/plain", forHTTPHeaderField: "Content-Type")
                req.httpMethod = "POST"
                req.httpBody = postData
                
                let task = URLSession.shared.dataTask(with: req) { data, response, error in
                    //print("pass")
                }
                
                task.resume()
                
                self.resetNote()
            } else {
                print("something wrong yo")
            }
        }
    }
}
