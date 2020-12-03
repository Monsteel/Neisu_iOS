//
//  SchoolDbManager.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/02.
//

import Foundation
import RxSwift
import RealmSwift

class SchoolDbManager: BaseDbManager {
    lazy var realm:Realm! = getReam()
    
    func saveSchool(school: School) -> Single<Void> {
        return Single<Void>.create { [weak self] single in
            guard let self = self else {
                single(.error(NeisuError.BasicError(message: "self is nil")))
                return Disposables.create()
            }
            do{
                try self.realm.write {
                    self.realm.delete(self.realm.objects(School.self))
                    self.realm.add(school)
                }
                single(.success(Void()))
            }
            catch{
                single(.error(NeisuError.DataBaseError(message: "Failed to save school data")))
            }
            return Disposables.create()
        }
    }
    
    func getSchool() -> Single<School> {
        return Single<School>.create { [weak self] single in
            guard let self = self else {
                single(.error(NeisuError.BasicError(message: "self is nil")))
                return Disposables.create()
            }
            
            let data = self.realm.objects(School.self)
            
            if(data.isEmpty){
                single(.error(NeisuError.BasicError(message: "Failed to get school data")))
            }else{
                single(.success(Array(data).first!))
            }
            
            return Disposables.create()
        }
    }
    
    func deleteMeal() -> Single<Void> {
        return Single<Void>.create { [weak self] single in
            guard let self = self else {
                single(.error(NeisuError.BasicError(message: "self is nil")))
                return Disposables.create()
            }
            
            do{
                try self.realm.write {
                    self.realm.delete(self.realm.objects(School.self))
                }
                single(.success(Void()))
            }
            catch{
                single(.error(NeisuError.DataBaseError(message: "Failed to delete school data")))
            }
            
            return Disposables.create()
        }
    }
}
