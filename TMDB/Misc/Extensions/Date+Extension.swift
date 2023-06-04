//
//  Date+Extension.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

public enum DateFormat: String {
    
    /// `dd-MM-yyyy` format
    case ddMMyyyyBars = "dd/MM/yyyy"
    case yyyyMMddHyphen = "yyyy-MM-dd"
    
    /// `yyyy-MM-dd HH:mm:ss` format
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
}

/// Date extension
public extension Date {
    /// Initializer
    /// - Parameters:
    ///   - string: Date string
    ///   - format: Input format
    init?(string: String, format: DateFormat) {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        if let date = formatter.date(from: string) {
            self = date
            return
        }
        
        return nil
    }
    
    /// Returns `self` as `String`
    /// - Parameter format: Output format
    /// - Parameter timeZoneData: Set custom timeZone
    func asString(format: DateFormat, timeZone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        
        return formatter.string(from: self)
    }
}
