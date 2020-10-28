//
//  InsertMealByMonthUseCase.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class InsertMealByMonthUseCase: ParamUseCase {
    
    let mealsRepository:MealsRepository!
    
    init(mealsRepository:MealsRepository){
        self.mealsRepository = mealsRepository
    }
    
    typealias Params = GetMealsRequest
    
    typealias T = Single<Void>
    
    func buildUseCaseObservable(params: GetMealsRequest) -> Single<Void> {
        return mealsRepository.insertMealByMonth(getMealsRequest: params)
    }
}
