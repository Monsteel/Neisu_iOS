//
//  MealsRemote.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/18.
//

import Foundation
import RxSwift

class MealsRemote: BaseRemote<NeisMealsSearchAPI> {
    func getMealByMonth(getMealsRequest: GetMealsRequest) -> Single<Array<Meal>> {
        decoder.dateDecodingStrategy = .formatted(Formatter.neisStyleDate)
        return provider.rx.request(.getMeals(getMealsRequest: getMealsRequest)).map(MealServiceDietInfoResponse.self, using: decoder)
            .map { [weak self] response in
                let statusHeader = response.head.headSecond.result
                
                if(statusHeader?.code != "INFO-000"){
                    throw NetWorkError.Custom(status: statusHeader?.code ?? "", errorBody: ["message":statusHeader?.message ?? ""])
                }else{
                    return self?.convertMeals(year: getMealsRequest.year, month: getMealsRequest.month, mealsInfoArray: response.row) ?? Array<Meal>()
                }
            }
    }
    
    private func convertMeals(year:Int, month:Int, mealsInfoArray :Array<MealInfo>) -> Array<Meal> {
        let currentDate = Date.from(year: year, month: month, day: 1)!
        
        var mealsArray = Array<Meal>()
        
        for i in 1 ... currentDate.getEndofMonth() {
            mealsArray.append(Meal(date: Date.from(year: year, month: month, day: i)!))
        }

        for mealsInfo in mealsInfoArray {
            for meal in mealsArray {
                if (mealsInfo.MLSV_YMD == meal.date){
                    switch Int(mealsInfo.MMEAL_SC_CODE) {
                        case MealsType.Breakfast.rawValue:
                            meal.setBreakfast(breakfast: mealsInfo.DDISH_NM)
                        case MealsType.Lunch.rawValue:
                            meal.setLunch(lunch: mealsInfo.DDISH_NM)
                        case MealsType.Dinner.rawValue:
                            meal.setDinner(dinner: mealsInfo.DDISH_NM)
                        default: break
                    }
                }
            }
        }
        
        return mealsArray
    }
}
