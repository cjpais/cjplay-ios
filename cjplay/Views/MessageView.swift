//
//  NotesView.swift
//  cjplay
//
//  Created by CJ Pais on 4/4/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes:FetchedResults<Note>
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(notes) { note in
                if note.createdAt != nil && note.body != nil {
                    VStack {
                        if displayDate(note: note) {
                            DateDividerView(date: note.createdAt!)
                                .padding()
                                .flip()
                        }
                        HStack() {
                            if displayTime() {
                                if note.createdAt != nil {
                                    Text(note.createdAt!.toTime())
                                        .font(.footnote)
                                        .foregroundColor(Color.gray)
                                }
                            }
                                
                            Spacer()
                            if note.body != nil {
                                NoteView(text: note.body!)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 1.0)
                        .flip()
                    }
                }
            }
        }.flip()
    }
}

func displayDate(note: Note) -> Bool {
    var ret: Bool = false
    if note.dateChanged != nil && note.dateChanged! == true {
        ret = true
    }
    return ret
}

func displayTime() -> Bool {
    return true
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
