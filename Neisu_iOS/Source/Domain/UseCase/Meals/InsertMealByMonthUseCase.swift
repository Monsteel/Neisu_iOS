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
    
    func buildUseCaseObservable(param: Param) -> Single<Void> {
        return mealsRepository.insertMealByMonth(pIndex: param.pIndex,
                                                 year: param.year,
                                                 month: param.month)
    }
    
    class Param {
        let pIndex:Int
        let year:Int
        let month:Int
        
        init(year:Int, month:Int, pIndex:Int = 1){
            self.year = year
            self.month = month
            self.pIndex = pIndex
        }
        
        init(date:Date, pIndex:Int = 1){
            self.year = date.year
            self.month = date.month
            self.pIndex = pIndex
        }
    }
}
