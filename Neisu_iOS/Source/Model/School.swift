//
//  School.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/02.
//

import Foundation
import RealmSwift

class School: Object {
    
    @objc dynamic var schoolName : String = ""
    @objc dynamic var schoolNameEnglish : String = ""
    @objc dynamic var schoolAdress : String = ""
    @objc dynamic var schoolCode : String = ""
    @objc dynamic var agencyCode : String = ""
    
    required init(schoolName:String, schoolNameEnglish:String, schoolAdress:String, schoolCode:String, agencyCode:String){
        self.schoolName = schoolName
        self.schoolNameEnglish = schoolNameEnglish
        self.schoolAdress = schoolAdress
        self.schoolCode = schoolCode
        self.agencyCode = agencyCode
    }
    
    required init() {
        self.schoolName = ""
        self.schoolNameEnglish = ""
        self.schoolAdress = ""
        self.schoolCode = ""
        self.agencyCode = ""
    }
}
