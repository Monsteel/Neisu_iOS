//
//  Meal.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/18.
//

import Foundation
import RealmSwift

class Meal: Object{
    
    @objc dynamic var exists = false
    @objc dynamic var breakfast : String = ""
    @objc dynamic var lunch : String = ""
    @objc dynamic var dinner : String = ""
    
    var date:Date?
    @objc dynamic var day:Int
    @objc dynamic var month:Int
    @objc dynamic var year:Int
    
    required init(date:Date, breakfast:String? = nil, lunch:String? = nil, dinner:String? = nil) {
        self.date = date
        self.year = date.year
        self.month = date.month
        self.day = date.day
        
        self.exists = (breakfast != nil) && (lunch != nil) && (dinner != nil)
        self.breakfast = breakfast ?? ""
        self.lunch = lunch ?? ""
        self.dinner = dinner ?? ""
    }
    
    required init() {
        self.year = -1
        self.month = -1
        self.day = -1
        
        self.exists = false
        self.breakfast = ""
        self.lunch = ""
        self.dinner = ""
    }
    
    
    func setBreakfast(breakfast:String) {
        self.breakfast = removeAllergyNumber(data: breakfast).replacingOccurrences(of: "<br/>", with: "\n")
        self.exists = true
    }
    
    func setLunch(lunch:String) {
        self.lunch = removeAllergyNumber(data: lunch).replacingOccurrences(of: "<br/>", with: "\n")
        self.exists = true
    }
    
    func setDinner(dinner:String) {
        self.dinner = removeAllergyNumber(data: dinner).replacingOccurrences(of: "<br/>", with: "\n")
        self.exists = true
    }
    
    func getDate() -> Date {
        guard let date = date else {
            return Date.from(year: year, month: month, day: day)!
        }
        return date
    }
    
    private func removeAllergyNumber(data: String?) -> String {
        if data == nil {
            return ""
        }
        else {
            let regex = try! NSRegularExpression(pattern:"\\d+\\.", options:[])

            let range = NSMakeRange(0, data!.count)
            return regex.stringByReplacingMatches(in: data!, options: [], range: range, withTemplate: " ")
        }
    }
}
