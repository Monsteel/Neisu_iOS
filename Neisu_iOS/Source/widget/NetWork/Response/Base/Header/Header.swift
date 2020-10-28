//
//  Header.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Foundation

class Header {
    var headFirst:ListCound!
    var headSecond:ResultStatus!
    
    init(headTemp:Array<HeadTemp>?){
        
        self.headFirst = ListCound(headTemp: headTemp?[0] ?? HeadTemp())
        self.headSecond = ResultStatus(headTemp: headTemp?[1] ?? HeadTemp())
    }
}
