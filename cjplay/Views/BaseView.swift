//
//  BaseView.swift
//  cjplay
//
//  Created by CJ Pais on 2/2/21.
//  Copyright © 2021 CJ Pais. All rights reserved.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
        GeometryReader { geometry in
            Text("\(geometry.size.height)")
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
