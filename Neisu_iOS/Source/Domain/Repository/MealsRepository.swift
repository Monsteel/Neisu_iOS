//
//  MealsRepository.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

protocol MealsRepository {
    func getMealByMonth(pIndex:Int, agencyCode:String, schoolCode:String, year:Int, month:Int) -> Single<Array<Meal>>
    
    func insertMealByMonth(pIndex:Int, agencyCode:String, schoolCode:String, year:Int, month:Int) -> Single<Void>
    
    func deleteAllMeal() -> Single<Void>
}
