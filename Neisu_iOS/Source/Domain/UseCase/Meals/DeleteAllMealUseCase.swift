//
//  DeleteAllMealUseCase.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class DeleteAllMealUseCase: BaseUseCase {
    
    let mealsRepository:MealsRepository!
    
    init(mealsRepository:MealsRepository){
        self.mealsRepository = mealsRepository
    }
    
    typealias T = Single<Void>
    
    func buildUseCaseObservable() -> Single<Void> {
        return mealsRepository.deleteAllMeal()
    }
}
