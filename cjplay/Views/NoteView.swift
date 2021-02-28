//
//  NoteView.swift
//  cjplay
//
//  Created by CJ Pais on 4/4/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct NoteView: View {
    
    var text: String
    
    var body: some View {
        ZStack {
            Text(text)
                .foregroundColor(.black)
                .padding(.vertical, 7.0)
                .padding(.horizontal, 11.0)
                .background(
                    RoundedRectangle(cornerRadius: 16.0)
                        .fill(Color.white)
                )
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(text: "this is a test string")
    }
}
