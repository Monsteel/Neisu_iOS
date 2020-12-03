//
//  CustomError.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 08/08/2020.
//

enum NeisuError: Error {
    case NetWorkError(status:String, errorBody: Dictionary<String, Any> = Dictionary())
    case DataBaseError(message:String,  errorBody: Dictionary<String, Any> = Dictionary())
    case BasicError(message:String)
}
