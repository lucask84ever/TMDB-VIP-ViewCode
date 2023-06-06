//
//  Date+Extension.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

public enum DateFormat: String {
    case ddMMyyyyBars = "dd/MM/yyyy"
    case yyyyMMddHyphen = "yyyy-MM-dd"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
}

public extension Date {
    init?(string: String, format: DateFormat) {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        if let date = formatter.date(from: string) {
            self = date
            return
        }
        
        return nil
    }
    
    func asString(format: DateFormat, timeZone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        
        return formatter.string(from: self)
    }
}
