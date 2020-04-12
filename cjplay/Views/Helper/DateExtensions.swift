//
//  DateExtensions.swift
//  cjplay
//
//  Created by CJ Pais on 4/11/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String = "dd MMM yyyy HH:mm:ss" ) -> String {
        return getFormat(format: format)
    }
    
    func toTime(format: String = "h:mm a") -> String {
        return getFormat(format: format)
    }
    
    func toDate(format: String = "EEEE, MMM d, yyyy") -> String {
        return getFormat(format: format)
    }
    
    private func getFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
