//
//  NotesView.swift
//  cjplay
//
//  Created by CJ Pais on 4/4/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct MessagesView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes(ascending: false)) var notes:FetchedResults<Note>

    var body: some View {
        ScrollView(.vertical) {
            ScrollViewReader { scrollView in
                LazyVStack(spacing: 1) {
                    ForEach(notes.reversed(), id: \.self) { note in
                        MessageView(note: note)
                    }
                }
                .onAppear {
                    scrollView.scrollTo(notes[0])
                }
            }
        }
        .padding(.bottom, 10)
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

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
