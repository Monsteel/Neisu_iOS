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
    
    func buildUseCaseObservable(param: Param) -> Single<Array<School>> {
        return schoolRepository.searchSchool(schoolName:param.schoolName, pIndex:param.pIndex)
    }
    
    class Param {
        let pIndex:Int
        let schoolName:String
        
        init(schoolName:String, pIndex:Int){
            self.schoolName = schoolName
            self.pIndex = pIndex
        }
    }
}
