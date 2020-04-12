//
//  CardView.swift
//  cjplay
//
//  Created by CJ Pais on 3/28/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct ConversationInputView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var note: String
    @EnvironmentObject var state: CJState
    
    var body: some View {
        HStack {
            VStack {
                TextView(text: $state.note, height: $state.textHeight)
                    .padding(.horizontal)
                    .padding(.vertical, 5.0)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1.0))
                    .offset(y: -min(state.textHeight, 175)/2 + 15) // max size of text box/2 + initial height/2
                    .frame(width: 350, height: min(state.textHeight, 175), alignment: .leading)
            }
            .padding(.bottom)
            
            Button(action: {
                let newNote = Note(context: self.managedObjectContext)
                newNote.body = self.state.note
                newNote.createdAt = Date()
                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
                
                self.state.textHeight = 30.0
                
                self.state.sendNote()
            })
            {
                Image(systemName: "arrow.up")
                    .foregroundColor(Color.white)
                    .padding(.all, 9.0)
                    .background(Circle().foregroundColor(Color.blue))
                    .font(Font.system(.body).bold())
            }.padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 47)
    }
    
}

struct ConversationInputView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack {
                ConversationInputView(note: "")
                    .environmentObject(CJState())
            }
        }
    }
}
