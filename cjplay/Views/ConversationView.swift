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
    @State var keyboardHeight: CGFloat = 0
    @State private var mode: String = "conversation"
    @State private var bool: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Flow")
                        .font(.title)
                        .bold()
                    Spacer()
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
                .padding([.horizontal, .top])
                
                Picker(selection: self.$state.mode, label: Text("mode")) {
                    ForEach(Mode.allCases) { mode in
                        Text(mode.string)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                /*
                Picker(selection: $state.mode) {
                    Mode.allCases.forEach {
                        Text("\($0.rawValue)")
                    }
                }.pickerStlye(SegmentedPickerStyle)
 */

                if (self.mode == "conversation") {
                    MessageView().frame(height: 388 - min(self.state.textHeight, 175))
                    //MessageView().frame(height: 200 - min(self.state.textHeight, 175))
                    Spacer()
                    //CommandPaletteView()
                    ConversationInputView(note: "")
                        .environmentObject(self.state)
                        .padding(.bottom, -getOffset(keyboardHeight: self.keyboardHeight, geometry: geometry))
                        .onAppear {
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (n) in
                                let value = n.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                                let height = value.height
                                print("keyboard opened")
                                self.keyboardHeight = height
                                print("keyboard height", height)
                            }
                        }
                }
                else
                {
                    Text("HI")
                    Spacer()
                }
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
