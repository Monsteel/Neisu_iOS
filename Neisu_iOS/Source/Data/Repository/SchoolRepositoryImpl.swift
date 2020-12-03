//
//  SchoolRepositoryImpl.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class SchoolRepositoryImpl:SchoolRepository {
    private let schoolDataSource: SchoolDataSource
    
    init(schoolDataSource: SchoolDataSource){
        self.schoolDataSource = schoolDataSource
    }
    
    func searchSchool(schoolName:String, pIndex:Int) -> Single<Array<School>> {
        return schoolDataSource.searchSchool(schoolName:schoolName, pIndex:pIndex)
    }
    
    func insertSchool(school: School) -> Single<Void>{
        return schoolDataSource.insertSchool(school: school)
    }
    
    func deleteSchool() -> Single<Void>{
        return schoolDataSource.deleteSchool()
    }
    
    func getSchool() -> Single<School>{
        return schoolDataSource.getSchool()
    }
}
