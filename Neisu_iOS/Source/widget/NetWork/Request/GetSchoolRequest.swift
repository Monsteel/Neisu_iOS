//
//  GetSchoolRequest.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/18.
//

import Foundation

class GetSchoolRequest: Codable {
    let pIndex:Int
    let schoolName:String
    
    init(schoolName:String, pIndex:Int){
        self.schoolName = schoolName
        self.pIndex = pIndex
    }
}
