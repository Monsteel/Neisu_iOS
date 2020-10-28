//
//  GetMealsRequest.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/18.
//

import Foundation

class GetMealsRequest: Codable {
    let pSize:Int
    let agencyCode:String
    let schoolCode:String
    let year:Int
    let month:Int
    
    init(year:Int, month:Int, pSize:Int = Constants.INFINITE_SCROLL_LIMIT){
        self.year = year
        self.month = month
        self.agencyCode = SchoolController.getInstance().getSchoolInfo().ATPT_OFCDC_SC_CODE
        self.schoolCode = SchoolController.getInstance().getSchoolInfo().SD_SCHUL_CODE
        self.pSize = pSize
    }
    
    func getDate() -> Date{
        return Date.from(year: year, month: month, day: 1) ?? Date()
    }
}
