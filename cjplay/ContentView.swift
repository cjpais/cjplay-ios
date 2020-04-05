//
//  ContentView.swift
//  cjplay
//
//  Created by CJ Pais on 3/28/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Note.getAllNotes()) var notes:FetchedResults<Note>
    
    @EnvironmentObject var state: CJState
    @State var keyboardHeight: CGFloat = 0
    @State var textHeight: CGFloat = 30.0
    
    var body: some View {
        //NavigationView {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Flow")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding([.horizontal, .top])
                
                HStack {
                    Text("Default")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                
                Spacer()
                NotesView()
                CardView(note: self.state.note, height: self.textHeight)
                    .environmentObject(self.state)
                    .padding(.bottom, -getOffset(keyboardHeight: self.keyboardHeight, geometry: geometry))
                    //.offset(y: getOffset(keyboardHeight: self.keyboardHeight, geometry: geometry))
            }
            //.offset(y: getOffset(keyboardHeight: self.keyboardHeight, geometry: geometry))
               // .animation(.linear(duration: 0.1))
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (n) in
                    let value = n.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    print("keyboard opened")
                    self.keyboardHeight = height
                    print("keyboard height", height)
                }
            }
        //}
        //.foregroundColor(Color.white)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CJState())
    }
}
