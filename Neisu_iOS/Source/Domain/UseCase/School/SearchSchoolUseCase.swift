//
//  SearchSchoolUseCase.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class SearchSchoolUseCase: ParamUseCase {
    
    
    let schoolRepository:SchoolRepository!
    
    init(schoolRepository:SchoolRepository){
        self.schoolRepository = schoolRepository
    }
    
    typealias Params = GetSchoolRequest
    typealias T = Single<Array<SchoolInfo>>
    
    
    func buildUseCaseObservable(params: GetSchoolRequest) -> Single<Array<SchoolInfo>>{
        return schoolRepository.searchSchool(getSchoolRequest: params)
    }
}
