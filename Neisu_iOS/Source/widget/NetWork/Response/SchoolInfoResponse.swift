//
//  SchoolInfoResponse.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Foundation

class SchoolInfoResponse: Decodable {
    var head:Header!
    var row:Array<SchoolInfo>!
    
    enum HeaderKeys : String, CodingKey{
        case schoolInfo
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: HeaderKeys.self)
        
        let temp = try container.decode(Array<Temp<SchoolInfo>>.self, forKey: .schoolInfo)
        
        self.head = temp[0].head
        self.row = temp[1].row
    }
}
