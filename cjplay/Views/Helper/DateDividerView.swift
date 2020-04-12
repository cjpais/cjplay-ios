//
//  DateDividerView.swift
//  cjplay
//
//  Created by CJ Pais on 4/4/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct DateDividerView: View {
    var date: Date
    
    var body: some View {
        ZStack {
            line
            Text(date.toDate())
                .font(.footnote)
                .foregroundColor(Color.gray)
                //.padding(.horizontal)
                .lineLimit(1)
                .background(Color.black)
        }
    }
    
    var line: some View {
        VStack {
            Divider()
        }
    }
}

struct DateDividerView_Previews: PreviewProvider {
    static var previews: some View {
        DateDividerView(date: Date())
    }
}
