//
//  Formatter.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 30/07/2020.
//

import Foundation

extension Formatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
    
    static let dateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
    static let neisStyleDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "yyyyMMdd"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
}
