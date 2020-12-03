//
//  Date.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 24/08/2020.
//

import Foundation

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
    
    static func from(hour: Int, minute: Int) -> Date? {
        let now = Date()
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: "KST")!
        var dateComponents = DateComponents()
        dateComponents.year = now.year
        dateComponents.month = now.month
        dateComponents.day = now.date
        dateComponents.hour = hour
        dateComponents.hour = minute
        return calendar.date(from: dateComponents) ?? nil
    }
    
    static func addDay(_ date: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: date, to: Date())!
    }
    
    func before(_ date: Date) -> Bool {
        return self < date
    }

    func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
    
    func add(_ year: Int = 0, month:Int = 0, date:Int = 0, hour:Int = 0, minute:Int = 0, second:Int = 0) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = self.year + year
        dateComponents.month = self.month + month
        dateComponents.day = self.date + date
        dateComponents.hour = self.hour + hour
        dateComponents.minute = self.minute + minute
        dateComponents.day = self.date + date
        dateComponents.second = self.second + second
        return calendar.date(from: dateComponents) ?? self
    }
    
    var month: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let month = Int(dateFormatter.string(from: self)) ?? 0
        return month
    }
    
    var year: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yaer = Int(dateFormatter.string(from: self)) ?? 0
        return yaer
    }
    
    var date: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let day = Int(dateFormatter.string(from: self)) ?? 0
        return day
    }
    
    var hour: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let day = Int(dateFormatter.string(from: self)) ?? 0
        return day
    }
    
    var minute: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        let day = Int(dateFormatter.string(from: self)) ?? 0
        return day
    }
    
    var second: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ss"
        let day = Int(dateFormatter.string(from: self)) ?? 0
        return day
    }
    
    func toString(format: String = "yyyy-MM-dd") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.amSymbol = "오전"
        dateFormatter.pmSymbol = "오후"
        
        return dateFormatter.string(from: self)
    }
}
