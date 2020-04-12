//
//  CommandInputView.swift
//  cjplay
//
//  Created by CJ Pais on 4/11/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct CommandPaletteView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var state: CJState
    @State private var showCmd: Bool = false
    @State private var animate: Bool = false
    
    var body: some View {
        VStack {
            
            /*
            TextView(text: $state.note, height: $state.textHeight)
            .padding(.horizontal)
            .padding(.vertical, 5.0)
            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1.0))
            .offset(y: -min(state.textHeight, 175)/2 + 15) // max size of text box/2 + initial height/2
            .frame(width: 350, height: min(state.textHeight, 175), alignment: .leading)
*/
            
            HStack {
                //ZStack(alignment: .leading){
                    TextView(text: self.$state.note, height: self.$state.textHeight)
                    .background(RoundedRectangle(cornerRadius: 30).stroke(Color.gray, lineWidth: 1.0))
                        .offset(y: -min(self.state.textHeight, 175)/2 + 15) // max size of text box/2 + initial height/2
                        .frame(width: self.showCmd ? 370: 40, height: min(40, 175), alignment: .leading)
                        .animation(.default)
                        .onAppear() {
                            self.animate.toggle()
                        }
                        .onDisappear() {
                            self.animate.toggle()
                        }
                    .padding(.bottom, 46)
                    .padding(.leading, 2)
                    .overlay(Button(action: {
                        self.showCmd.toggle()
                    })
                    {
                        Image(systemName: "greaterthan.square")
                            .foregroundColor(Color.white)
                            .padding(.all, 9.0)
                            .background(Circle().foregroundColor(Color.gray))
                            .font(Font.system(.body).bold())
                            .padding(.leading, 5)
                    }.padding(.bottom), alignment: .leading)
                    
                //}.frame(width: 350)
                
                Spacer()
                
                Button(action: {
                    /*
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
                    */
                })
                {
                    Image(systemName: "arrow.up")
                        .foregroundColor(Color.white)
                        .padding(.all, 9.0)
                        .background(Circle().foregroundColor(Color.blue))
                        .font(Font.system(.body).bold())
                }.padding(.bottom)
            }.background(Color.green)
        }
        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 47)
    }
}

struct CommandPaletteView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack {
                CommandPaletteView()
                    .environmentObject(CJState())
            }
        }
    }
}
