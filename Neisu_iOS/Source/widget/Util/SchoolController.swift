//
//  SchoolController.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import Foundation

class SchoolController {
    let preferences = UserDefaults.standard
    
    func setSchool(schoolInfo:SchoolInfo){
        preferences.set(true, forKey: "isSetSchool")
        preferences.set(schoolInfo, forKey: "schoolInfo")
    }
    
    func deleteSchool(){
        preferences.set(nil, forKey: "isSetSchool")
        preferences.set(nil, forKey: "schoolInfo")
    }
    
    
    func getSchoolInfo() -> School {
        return preferences.value(forKey: "schoolInfo") as? School ?? School()
    }
    
    func getIsSetSchool() -> Bool{
        return preferences.value(forKey: "isSetSchool") as? Bool ?? false
    }
}

extension SchoolController {
    static var schoolController:SchoolController!
    
    static func getInstance() -> SchoolController {
        if(SchoolController.schoolController == nil){
            SchoolController.schoolController = SchoolController()
        }
        
        return .schoolController
    }
}
