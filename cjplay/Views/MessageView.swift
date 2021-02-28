//
//  MessageView.swift
//  cjplay
//
//  Created by CJ Pais on 6/29/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    
    @State var note: Note
    
    var body: some View {
        VStack {
            if displayDate(note: note) {
                DateDividerView(date: note.createdAt!)
                    .padding()
            }
            HStack() {
                
                if note.synced != nil {
                    Image(systemName: getNoteSyncIcon(note))
                } else {
                    Text("nil")
                }
                
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
        }
    }
    
    func getNoteSyncIcon(_ note: Note) -> (String) {
        return note.synced! as! Bool ? "checkmark.icloud" : "xmark.icloud"
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(note: Note())
    }
}
