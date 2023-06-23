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
    case yyyyMMddHHmmssZZZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case yyyy = "yyyy"
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
    
    func asString(format: DateFormat,
                  timeZone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        
        return formatter.string(from: self)
    }
    
    static func - (recent: Date,
                  previous: Date) -> (year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let year = Calendar.current.dateComponents([.year], from: previous, to: recent).year
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }
}
