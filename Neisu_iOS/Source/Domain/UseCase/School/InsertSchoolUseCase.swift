//
//  InsertSchoolUseCase.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/02.
//

import RxSwift

class InsertSchoolUseCase: ParamUseCase {
    let schoolRepository:SchoolRepository!
    
    init(schoolRepository:SchoolRepository){
        self.schoolRepository = schoolRepository
    }
    
    func buildUseCaseObservable(param: Param) -> Single<Void> {
        return schoolRepository.insertSchool(school: param.school )
    }
    
    class Param {
        let school:School

        init(school:School){
            self.school = school
        }
    }
}
