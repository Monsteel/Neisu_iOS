//
//  ParamUseCase.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 13/08/2020.
//

import Foundation

protocol ParamUseCase {
    associatedtype Params
    associatedtype T
    func buildUseCaseObservable(params:Params) -> T
}
