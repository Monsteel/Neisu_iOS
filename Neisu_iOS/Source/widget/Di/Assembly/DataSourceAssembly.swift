//
//  DataSourceAssembly.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 02/08/2020.
//

import Foundation
import Swinject

class DataSourceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MealsDataSource.self) { _ in
            MealsDataSource(remote: MealsRemote(), cache: MealsCache())
        }.inObjectScope(.container)
        
        container.register(SchoolDataSource.self) { r in
            SchoolDataSource(remote: SchoolRemote(), cache: nil)
        }
    }
}
