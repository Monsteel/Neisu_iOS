//
//  SchoolDataSource.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class SchoolDataSource: BaseDataSource<SchoolRemote, SchoolCache> {
    func searchSchool(schoolName:String, pIndex:Int) -> Single<Array<School>>{
        return remote.searchSchool(schoolName:schoolName, pIndex:pIndex)
    }
    
    func insertSchool(school: School) -> Single<Void>{
        return cache.insertSchool(school: school)
    }
    
    func deleteSchool() -> Single<Void>{
        return cache.deleteSchool()
    }
    
    func getSchool() -> Single<School>{
        return cache.getSchool()
    }
}
