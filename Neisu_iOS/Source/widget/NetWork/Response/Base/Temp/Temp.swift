//
//  Temp.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Foundation

class Temp<T: Decodable>: Decodable {
    var head:Header?
    var row:Array<T>?
    
    
    enum TempKeys : String, CodingKey{
        case head
        case row
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: TempKeys.self)
        
        let tempHead = try container.decodeIfPresent(Array<HeadTemp>.self, forKey: .head)
        
        self.head = Header(headTemp: tempHead)
        
        self.row = try container.decodeIfPresent(Array<T>.self, forKey: .row)
    }
}
