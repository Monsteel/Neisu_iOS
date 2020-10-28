//
//  BaseRemote.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 29/07/2020.
//

import Foundation
import Moya
import RxSwift
import Alamofire

class BaseRemote<T: TargetType>{
    let provider = MoyaProvider<T>(plugins: [NetworkLoggerPlugin()])
    let decoder = JSONDecoder()
}
