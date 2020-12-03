//
//  MealsDataSource.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/21.
//

import Foundation
import RxSwift

class MealsDataSource: BaseDataSource<MealsRemote, MealsCache> {
    func getMealByMonth(pIndex:Int, agencyCode:String, schoolCode:String, year:Int, month:Int) -> Single<Array<Meal>>{
        return cache.getMealByMonth(year: year, month: month).catchError { [weak self] _ -> PrimitiveSequence<SingleTrait, Array<Meal>> in
            guard let self = self else { throw NeisuError.BasicError(message: "self is nil") }
            return self.getMealByMonthRemote(pIndex: pIndex, agencyCode: agencyCode, schoolCode: schoolCode, year: year, month: month)
        }
    }

    func insertMealByMonth(pIndex:Int, agencyCode:String, schoolCode:String, year:Int, month:Int) -> Single<Void> {
        return remote.getMealByMonth(pIndex: pIndex, agencyCode: agencyCode, schoolCode: schoolCode, year: year, month: month).flatMap { [weak self] response -> Single<Void> in
            guard let self = self else { throw NeisuError.BasicError(message: "self is nil") }
            return self.cache.insertMealList(meals: response)
        }
    }

    func deleteAllMeal() -> Single<Void> {
        return cache.deleteAllMeal()
    }

    private func getMealByMonthRemote(pIndex:Int, agencyCode:String, schoolCode:String, year:Int, month:Int) -> Single<Array<Meal>>{
        return remote.getMealByMonth(pIndex: pIndex, agencyCode: agencyCode, schoolCode: schoolCode, year: year, month: month).flatMap { [weak self] response -> Single<Array<Meal>> in
            guard let self = self else { throw NeisuError.BasicError(message: "self is nil") }
            return self.cache.insertMealList(meals: response).map { response }
        }
    }
}
