//
//  ParamUseCase.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 13/08/2020.
//

protocol ParamUseCase {
    associatedtype T
    associatedtype P
    func buildUseCaseObservable(param:P) -> T
}
