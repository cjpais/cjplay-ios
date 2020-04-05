//
//  NotesView.swift
//  cjplay
//
//  Created by CJ Pais on 4/4/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct NotesView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes:FetchedResults<Note>
    
    @EnvironmentObject var state: CJState
    //@State var note: String
    
    var body: some View {
        
        ScrollView(.vertical) {
            ForEach(notes) { note in
                if note.createdAt != nil && note.body != nil {
                    if displayDate() {
                        //DateDividerView()
                    }
                    HStack {
                        if displayTime() {
                            if note.createdAt != nil {
                                Text(note.createdAt!.toTime())
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                                    .rotationEffect(.radians(.pi)).scaleEffect(x: -1, y: 1, anchor: .center)
                            }
                        }
                            
                        Spacer()
                        if note.body != nil {
                            NoteView(text: note.body!)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 1.0)
                }
            }
        }.rotationEffect(.radians(.pi)).scaleEffect(x: -1, y: 1, anchor: .center)
    }
}

extension Date {
    func toString(format: String = "dd MMM yyyy HH:mm:ss" ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toTime(format: String = "h:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

func displayDate() -> Bool {
    return true
}

func displayTime() -> Bool {
    return true
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
            .environmentObject(CJState())
    }
}
