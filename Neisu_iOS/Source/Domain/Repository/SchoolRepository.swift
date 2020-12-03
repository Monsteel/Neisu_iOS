//
//  SchoolRepository.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

protocol SchoolRepository {
    func searchSchool(schoolName:String, pIndex:Int) -> Single<Array<School>>
    
    func insertSchool(school: School) -> Single<Void>
    
    func deleteSchool() -> Single<Void>
    
    func getSchool() -> Single<School>
}
