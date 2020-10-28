//
//  MealsRepository.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

protocol MealsRepository {
    func getMealByMonth(getMealsRequest: GetMealsRequest) -> Single<Array<Meal>>

    func insertMealByMonth(getMealsRequest: GetMealsRequest) -> Single<Void>

    func deleteAllMeal() -> Single<Void>
}
