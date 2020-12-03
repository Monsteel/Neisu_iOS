//
//  SchoolCache.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/02.
//

import RxSwift

class SchoolCache:BaseCache {
    private let schoolDbManager = SchoolDbManager()
    
    func insertSchool(school: School) -> Single<Void> {
        return schoolDbManager.saveSchool(school: school)
    }
    
    func deleteSchool() -> Single<Void> {
        return schoolDbManager.deleteMeal()
    }
    
    func getSchool() -> Single<School> {
        return schoolDbManager.getSchool()
    }
}
