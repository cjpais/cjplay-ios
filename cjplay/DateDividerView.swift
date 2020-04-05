//
//  DateDividerView.swift
//  cjplay
//
//  Created by CJ Pais on 4/4/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import SwiftUI

struct DateDividerView: View {
    var body: some View {
        HStack {
            line
            Text("April 4, 2020")
                .font(.footnote)
                .foregroundColor(Color.gray)
            line
        }
    }
    
    var line: some View {
        VStack {
            Divider()
                .padding(.horizontal)
        }
    }
}

struct DateDividerView_Previews: PreviewProvider {
    static var previews: some View {
        DateDividerView()
    }
}
