//
//  MealsCache.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/21.
//

import RxSwift

class MealsCache:BaseCache {
    private let mealDbManager = MealDbManager()
    
    func insertMealList(meals: Array<Meal>) -> Single<Void> {
        return mealDbManager.saveMealData(mealList: meals)
    }
    
    func deleteAllMeal() -> Single<Void> {
        return mealDbManager.deleteAllMeal()
    }
    
    func getMealByMonth(year:Int, month:Int) -> Single<Array<Meal>> {
        return mealDbManager.getMealByMonth(year: year, month: month)
    }
}
