//
//  CardView.swift
//  cjplay
//
//  Created by CJ Pais on 3/28/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var note: String
    @State var height: CGFloat = 30.0
    @EnvironmentObject var state: CJState
    
    var body: some View {
        HStack {
            VStack {
                TextView(text: $state.note, height: $height)
                    .padding(.horizontal)
                    .padding(.vertical, 5.0)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1.0))
                    .offset(y: -height/2 + 15)
                    .frame(width: 350, height: height, alignment: .leading)
            }
            .padding([.horizontal, .bottom])
            
            VStack {
                Button(action: {
                    print("hit")
                    let newNote = Note(context: self.managedObjectContext)
                    newNote.body = self.state.note
                    newNote.createdAt = Date()
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                    
                    self.height = 30.0
                    
                    self.state.sendNote()
                })
                {
                    ZStack {
                        Image(systemName: "arrow.up")
                            .foregroundColor(Color.white)
                            .padding(.all, 9.0)
                            .background(Circle().foregroundColor(Color.blue))
                            .font(Font.system(.body).bold())
                    }
                }
            }
            .padding([.trailing, .bottom])
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 47)
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack {
                CardView(note: "", height: 30.0)
                    .environmentObject(CJState())
            }
        }
    }
}
