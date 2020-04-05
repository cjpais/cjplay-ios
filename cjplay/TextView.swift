//
//  TextView.swift
//  cjplay
//
//  Created by CJ Pais on 4/4/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    /*
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Note.id, ascending: true),
        ]
    ) var notes: FetchedResults<Note>
    */
    
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
        textView.backgroundColor = .black
        
        textView.becomeFirstResponder()
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.delegate = context.coordinator
        uiView.text = text

        /*
        print(notes.count)
        if notes.count == 0 {
            print("creating new note")
            let newNote = Note(context: managedObjectContext)
            newNote.id = 0
            newNote.body = text
        } else {
            print("updating existing note")
            notes[0].id = 0
            notes[0].body = text
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            //print(error)
        }
         */
    }
    
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            print(textView.contentSize.height)
            parent.height = textView.contentSize.height + 10
        }
    }
}
