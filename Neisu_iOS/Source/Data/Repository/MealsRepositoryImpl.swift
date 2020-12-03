//
//  MealsRepositoryImpl.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class MealsRepositoryImpl:MealsRepository {
    private let mealsDataSource: MealsDataSource
    private let schoolDataSource: SchoolDataSource
    
    init(mealsDataSource: MealsDataSource, schoolDataSource: SchoolDataSource){
        self.mealsDataSource = mealsDataSource
        self.schoolDataSource = schoolDataSource
    }
    
    func getMealByMonth(pIndex:Int, year:Int, month:Int) -> Single<Array<Meal>> {
        return schoolDataSource.getSchool()
            .flatMap { [weak self] school -> Single<Array<Meal>> in
                guard let self = self else { throw NeisuError.BasicError(message: "self is nil") }
                return self.mealsDataSource.getMealByMonth(pIndex: pIndex, agencyCode: school.agencyCode, schoolCode: school.schoolCode, year: year, month: month)
            }
    }
    
    func insertMealByMonth(pIndex:Int, year:Int, month:Int) -> Single<Void> {
        return schoolDataSource.getSchool()
            .flatMap { [weak self] school -> Single<Void> in
                guard let self = self else { throw NeisuError.BasicError(message: "self is nil") }
                return self.mealsDataSource.insertMealByMonth(pIndex: pIndex, agencyCode: school.agencyCode, schoolCode: school.schoolCode, year: year, month: month)
            }
    }
    
    func deleteAllMeal() -> Single<Void> {
        return mealsDataSource.deleteAllMeal()
    }
}
