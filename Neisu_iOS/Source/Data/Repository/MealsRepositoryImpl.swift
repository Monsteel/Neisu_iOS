//
//  MealsRepositoryImpl.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class MealsRepositoryImpl:MealsRepository {
    private let mealsDataSource: MealsDataSource
    
    init(mealsDataSource: MealsDataSource){
        self.mealsDataSource = mealsDataSource
    }

    func getMealByMonth(getMealsRequest: GetMealsRequest) -> Single<Array<Meal>> {
        return mealsDataSource.getMealByMonth(getMealsRequest: getMealsRequest)
    }
    
    func insertMealByMonth(getMealsRequest: GetMealsRequest) -> Single<Void> {
        return mealsDataSource.insertMealByMonth(getMealsRequest: getMealsRequest)
    }
    
    func deleteAllMeal() -> Single<Void> {
        return mealsDataSource.deleteAllMeal()
    }
}
