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
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(note: Note())
    }
}
