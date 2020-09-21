//
//  ContentView.swift
//  cjplay
//
//  Created by CJ Pais on 3/28/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI
import Combine

struct ConversationView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes:FetchedResults<Note>
    
    @EnvironmentObject var state: CJState
    //@State var keyboardHeight: CGFloat = 0
    @State private var mode: String = "conversation"
    @State private var bool: Bool = false
    
    var title: some View {
        Text("Flow")
            .font(.title)
            .bold()
    }
    
    var modeSwitch: some View {
        Button(action: {
            if self.mode == "conversation" {
                self.mode = "podcast"
            } else {
                self.mode = "conversation"
            }
        })
        {
            if self.mode == "conversation" {
                Text("podcast")
                //Image(systemName: "mic.fill")
            }
            else {
                Text("conversation")
                //Image(systemName: "bubble.right.fill")
            }
        }
    }
    
    var devPicker: some View {
        Picker(selection: self.$state.mode, label: Text("mode")) {
            ForEach(Mode.allCases) { mode in
                Text(mode.string)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                HStack {
                    title
                    Spacer()
                    modeSwitch
                }
                .padding([.horizontal, .top])
                
                devPicker
                
                MessagesView().frame(height: 388 - min(self.state.textHeight, 175))
                Spacer()
                ConversationInputView(note: "") {
                    print("LOLOLOL")
                }
                .environmentObject(self.state)
            }
        }
    }
}

func getOffset(keyboardHeight: CGFloat, geometry: GeometryProxy) -> CGFloat {
    if keyboardHeight != 0 {
        return (-keyboardHeight + geometry.safeAreaInsets.top)
    }
    else {
        return 0
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
            .environmentObject(CJState())
    }
}
