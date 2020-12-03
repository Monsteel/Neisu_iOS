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
    
    func buildUseCaseObservable(param: Param) -> Single<Array<Meal>> {
        return mealsRepository.getMealByMonth(pIndex: param.pIndex,
                                              agencyCode: param.agencyCode,
                                              schoolCode: param.schoolCode,
                                              year: param.year,
                                              month: param.month)
    }
    
    class Param {
        let pIndex:Int
        let agencyCode:String
        let schoolCode:String
        let year:Int
        let month:Int
        
        init(year:Int, month:Int, agencyCode: String, schoolCode:String, pIndex:Int = 1){
            self.year = year
            self.month = month
            self.agencyCode = agencyCode
            self.schoolCode = schoolCode
            self.pIndex = pIndex
        }
    }
}
