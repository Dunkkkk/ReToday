//
//  Time.swift
//  
//
//  Created by changgyo seo on 2023/04/13.
//

import Foundation
import Combine

class Time {
    
    static var shared: Time = Time()
    var current: Date
    var year: String = ""
    var month: String = ""
    var day: String = ""
    
    // Singleton pattern
    private init() {
        self.current = Date()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "yyyy"
            self.year = formatter.string(from: Date())
            formatter.dateFormat = "MM"
            self.month = formatter.string(from: Date())
            formatter.dateFormat = "dd"
            self.day = formatter.string(from: Date())
            
        }.tolerance = 1
    }
}

