//
//  Result.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Foundation

class ResultStatus: Decodable {
    var result:Result!
    
    init(headTemp: HeadTemp){
        self.result = headTemp.result
    }
}

class Result: Decodable {
    var code:String!
    var message:String!
    
    enum StudentKeys : String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: StudentKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
    }
}
