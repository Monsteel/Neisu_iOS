//
//  MealsDataSource.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/21.
//

import Foundation
import RxSwift

class MealsDataSource: BaseDataSource<MealsRemote, MealsCache> {
    func getMealByMonth(getMealsRequest: GetMealsRequest) -> Single<Array<Meal>>{
        return cache.getMealByMonth(getMealsRequest: getMealsRequest).catchError { [weak self] _ -> PrimitiveSequence<SingleTrait, Array<Meal>> in
            guard let self = self else {
                return .error(CustomError.Custom(errorMessage: "self is nil"))
            }
            return self.getMealByMonthRemote(getMealsRequest: getMealsRequest)
        }
    }

    func insertMealByMonth(getMealsRequest: GetMealsRequest) -> Single<Void> {
        return remote.getMealByMonth(getMealsRequest: getMealsRequest).flatMap { [weak self] response -> Single<Void> in
            guard let self = self else {
                return .error(CustomError.Custom(errorMessage: "self is nil"))
            }
            return self.cache.insertMealList(meals: response)
        }
    }

    func deleteAllMeal() -> Single<Void> {
        return cache.deleteAllMeal()
    }

    private func getMealByMonthRemote(getMealsRequest: GetMealsRequest) -> Single<Array<Meal>>{
        return remote.getMealByMonth(getMealsRequest: getMealsRequest).flatMap { [weak self] response -> Single<Array<Meal>> in
            guard let self = self else {
                return .error(CustomError.Custom(errorMessage: "self is nil"))
            }
            return self.cache.insertMealList(meals: response).map { _ -> Array<Meal> in
                return response
            }
        }
    }
}

