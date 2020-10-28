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
    
    func searchSchool(getSchoolRequest: GetSchoolRequest) -> Single<Array<SchoolInfo>> {
        return schoolDataSource.searchSchool(getSchoolRequest: getSchoolRequest)
    }   
}
