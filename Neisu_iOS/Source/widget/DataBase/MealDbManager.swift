//
//  MealDbManager.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 26/08/2020.
//

import Foundation
import RxSwift
import RealmSwift

class MealDbManager: BaseDbManager {
    lazy var realm:Realm! = getReam()
    
    func saveMealData(mealList: Array<Meal>) -> Single<Void> {
        return Single<Void>.create { [weak self] single in
            guard let self = self else {
                single(.error(NeisuError.BasicError(message: "self is nil")))
                return Disposables.create()
            }
            do{
                try self.realm.write {
                    self.realm.delete(self.realm.objects(Meal.self))
                    self.realm.add(mealList)
                }
                single(.success(Void()))
            }
            catch{
                single(.error(NeisuError.DataBaseError(message: "Failed to save meals data")))
            }
            return Disposables.create()
        }
    }
    
    func getAllMeal() -> Single<Array<Meal>> {
        return Single<Array<Meal>>.create { [weak self] single in
            guard let self = self else {
                single(.error(NeisuError.BasicError(message: "self is nil")))
                return Disposables.create()
            }
            
            let data = self.realm.objects(Meal.self)
            
            if(data.isEmpty){
                single(.error(NeisuError.BasicError(message: "Failed to get meals data")))
            }else{
                single(.success(Array(data)))
            }
            
            return Disposables.create()
        }
    }
    
    func getMealByMonth(year: Int, month: Int) -> Single<Array<Meal>> {
        return Single<Array<Meal>>.create { [weak self] single in
            guard let self = self else {
                single(.error(NeisuError.BasicError(message: "self is nil")))
                return Disposables.create()
            }
            
            let yearPredicate = NSPredicate(format: "year == \(year)")
            let monthPredicate = NSPredicate(format: "month == \(month)")
            
            let data = self.realm.objects(Meal.self).filter(yearPredicate)
                                               .filter(monthPredicate)
            
            if(data.isEmpty){
                single(.error(NeisuError.DataBaseError(message: "Failed to get meals data")))
            }else{
                single(.success(Array(data)))
            }
            
            return Disposables.create()
        }
    }
    
    func deleteAllMeal() -> Single<Void> {
        return Single<Void>.create { [weak self] single in
            guard let self = self else {
                single(.error(NeisuError.BasicError(message: "self is nil")))
                return Disposables.create()
            }
            
            do{
                try self.realm.write {
                    self.realm.delete(self.realm.objects(Meal.self))
                }
                single(.success(Void()))
            }
            catch{
                single(.error(NeisuError.DataBaseError(message: "Failed to delete meals data")))
            }
            
            return Disposables.create()
        }
    }
}
