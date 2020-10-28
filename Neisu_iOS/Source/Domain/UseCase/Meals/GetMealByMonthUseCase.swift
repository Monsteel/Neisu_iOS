//
//  GetMealByMonthUseCase.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class GetMealByMonthUseCase: ParamUseCase {
    
    let mealsRepository:MealsRepository!
    
    init(mealsRepository:MealsRepository){
        self.mealsRepository = mealsRepository
    }
    
    typealias Params = GetMealsRequest
    typealias T = Single<Array<Meal>>
    
    
    func buildUseCaseObservable(params: GetMealsRequest) -> Single<Array<Meal>> {
        return mealsRepository.getMealByMonth(getMealsRequest: params)
    }
}
