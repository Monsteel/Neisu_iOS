//
//  BaseUseCase.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 12/08/2020.
//

import Foundation

protocol BaseUseCase {
    associatedtype T
    func buildUseCaseObservable() -> T
}
