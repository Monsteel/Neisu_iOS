//
//  NetWorkError.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 08/08/2020.
//

enum NetWorkError: Error {
    case NetWorkError
    case Custom(status: String = "", errorBody: Dictionary<String, Any> = Dictionary())
}
