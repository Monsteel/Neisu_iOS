//
//  MealServiceDietInfoResponse.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Foundation

class MealServiceDietInfoResponse: Decodable {
    var head:Header!
    var row:Array<MealInfo>!
    
    enum HeaderKeys : String, CodingKey{
        case mealServiceDietInfo
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: HeaderKeys.self)
        
        let temp = try container.decode(Array<Temp<MealInfo>>.self, forKey: .mealServiceDietInfo)
        
        self.head = temp[0].head
        self.row = temp[1].row
    }
}
