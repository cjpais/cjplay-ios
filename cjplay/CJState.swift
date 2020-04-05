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

class CJState: ObservableObject {
    //@Published var notes: [Note]
    
    @Published var count: Int = 0
    @Published var note: String = ""
    
    func resetNote() {
        self.note = ""
    }
    
    func saveNote() {
        
    }
    
    func sendNote() {
        
        if self.note != "" {
            if let url = URL(string: "http://192.168.1.130:8080/note/new") {
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
                
                self.saveNote()
                self.resetNote()
            } else {
                print("something wrong yo")
            }
        }
    }
}
