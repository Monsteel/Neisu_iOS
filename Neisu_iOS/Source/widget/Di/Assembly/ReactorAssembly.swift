//
//  ReactorAssembly.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 31/07/2020.
//

import Foundation
import Swinject

class ReactorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SplashViewReactor.self) { r in
            SplashViewReactor(getSchoolUseCase: r.resolve(GetSchoolUseCase.self)!)
        }
        
        container.register(MealsViewReactor.self) { r in
            MealsViewReactor(getMealByMonthUseCase: r.resolve(GetMealByMonthUseCase.self)!,
                             getSchoolUseCase: r.resolve(GetSchoolUseCase.self)!)
        }
        
        container.register(SettingsTableViewReactor.self) { r in
            SettingsTableViewReactor(deleteSchoolUseCase: r.resolve(DeleteSchoolUseCase.self)!,
                                     deleteAllMealUseCase: r.resolve(DeleteAllMealUseCase.self)!,
                                     insertMealByMonthUseCase: r.resolve(InsertMealByMonthUseCase.self)!,
                                     getSchoolUseCase: r.resolve(GetSchoolUseCase.self)!)
        }
        
        container.register(SelectSchoolViewReactor.self) { r in
            SelectSchoolViewReactor(searchSchoolUseCase: r.resolve(SearchSchoolUseCase.self)!)
        }
        
        container.register(CheckSchoolViewReactor.self) { r in
            CheckSchoolViewReactor(insertSchoolUseCase: r.resolve(InsertSchoolUseCase.self)!)
        }
    }
}
