//
//  HeadTemp.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Foundation

class HeadTemp: Decodable {
    var listTotalCount: Int?
    var result:Result?
    
    
    init(){}
    
    init(listTotalCount:Int?, result:Result?){
        self.listTotalCount = listTotalCount
        self.result = result
    }
    
    enum TempKeys : String, CodingKey{
        case listTotalCount = "list_total_count"
        case result = "RESULT"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: TempKeys.self)
        
        self.listTotalCount = try container.decodeIfPresent(Int.self, forKey: .listTotalCount)
        self.result = try container.decodeIfPresent(Result.self, forKey: .result)
    }
}
