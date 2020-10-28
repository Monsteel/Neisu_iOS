//
//  UseCaseAssembly.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 06/08/2020.
//

import Foundation
import Swinject

class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetMealByMonthUseCase.self) { r in
            GetMealByMonthUseCase(mealsRepository: r.resolve(MealsRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(InsertMealByMonthUseCase.self) { r in
            InsertMealByMonthUseCase(mealsRepository: r.resolve(MealsRepository.self)!)
        }.inObjectScope(.container)

        container.register(DeleteAllMealUseCase.self) { r in
            DeleteAllMealUseCase(mealsRepository: r.resolve(MealsRepository.self)!)
        }.inObjectScope(.container)
        
        
        container.register(SearchSchoolUseCase.self) { r in
            SearchSchoolUseCase(schoolRepository: r.resolve(SchoolRepository.self)!)
        }.inObjectScope(.container)
    }
}
