//
//  File.swift
//  
//
//  Created by changgyo seo on 2023/04/13.
//

import Foundation

extension Date {
    //파라미터의 오늘이 담길 예정
    func isBeforeYears(comapare date: Date, howMany: Double) -> Bool {
        let secondsInYear = Double(60 * 60 * 24 * 365)
        let timeInterval = date.timeIntervalSince(Time.shared.current)
        let timeIntervalInYears = timeInterval / secondsInYear

        if timeIntervalInYears.truncatingRemainder(dividingBy: 1) == howMany {
            return true
        }
        return false
    }
    
    func dateToString() -> String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy .MM .dd"
        
        return formatter.string(from: self)
    }
    
    func dateToYYMMDD() -> (y: String, m: String, d: String) {
        var year = ""
        var month = ""
        var day = ""
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy"
        year = formatter.string(from: self)
        formatter.dateFormat = "MM"
        month = formatter.string(from: self)
        formatter.dateFormat = "dd"
        day = formatter.string(from: self)
        
        return (year, month, day)
    }
}
