//
//  RepositoryAssembly.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 31/07/2020.
//

import Foundation
import Swinject

class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MealsRepository.self) { r in
            MealsRepositoryImpl(mealsDataSource: r.resolve(MealsDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register(SchoolRepository.self) { r in
            SchoolRepositoryImpl(schoolDataSource: r.resolve(SchoolDataSource.self)!)
        }.inObjectScope(.container)
    }
}
