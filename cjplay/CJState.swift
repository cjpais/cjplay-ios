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
import Streamable

let thoughtApiPath: String = "/new/thought"

enum Mode: String, CaseIterable, Identifiable {
    case stream
    case dev
    
    var id: Mode {
        self
    }
    
    var port: String {
        (self.rawValue == "stream") ? "8080" : "10000"
    }
    
    var string: String {
        rawValue.prefix(1).uppercased() + rawValue.dropFirst()
    }
    
}

class CJState: ObservableObject {
    @Published var count: Int = 0
    @Published var thought: String = ""
    @Published var textHeight: CGFloat = 0.0
    @Published var mode: Mode = .stream
    
    private var api_path: String {
        "/\(mode.rawValue)\(thoughtApiPath)"
    }
    
    private var base_path: String {
        "\(ip_addr)/\(mode.rawValue)"
    }

    func resetThought() {
        self.thought = ""
    }
    
    func sendThought(note: Note, context: NSManagedObjectContext) {
        
        if note.body != "" {
            let config = StreamConfig(namespace: "cj/notes", name: "thoughts", version: "0.0.1", uuid: note.id!, location: nil, b64auth: streamAuth)
            let streamable = StreamableData<String>(config: config, data: self.thought)
            streamable.sendStream(to: base_path,
                                  completionHandler: { e in
                                    if e != nil {
                                        note.synced = false
                                        print("failed to send stream. no error")
                                    } else {
                                        note.synced = true
                                        print("completed request")
                                    }
                                    
                                    do {
                                        try context.save()
                                    } catch {
                                        print(error)
                                    }
                                  })
            
            if let url = URL(string: "\(ip_addr)\(api_path)") {
                print(url.absoluteURL)
                let postData = note.body!.data(using: String.Encoding.utf8)
                var req = URLRequest(url: url)
                req.setValue("text/plain", forHTTPHeaderField: "Content-Type")
                req.setValue("Basic \(streamAuth)", forHTTPHeaderField: "Authorization")
                req.httpMethod = "POST"
                req.httpBody = postData
                
                let task = URLSession.shared.dataTask(with: req) { data, response, error in
                    //print("pass")
                }
                
                task.resume()
                
                self.resetThought()
            } else {
                print("something wrong yo")
            }
        }
    }
}
