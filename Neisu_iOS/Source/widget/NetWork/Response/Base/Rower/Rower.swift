//
//  Rower.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Foundation

class Rower<T: Decodable>: Decodable {
    let row:Array<T>
}
