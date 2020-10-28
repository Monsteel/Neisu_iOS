//
//  ListCount.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Foundation

class ListCound {
    let listTotalCount:Int
    
    init(headTemp: HeadTemp){
        self.listTotalCount = headTemp.listTotalCount ?? 0
    }
}
