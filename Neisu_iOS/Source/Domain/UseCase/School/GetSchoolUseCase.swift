//
//  GetSchoolUseCase.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/02.
//

import RxSwift

class GetSchoolUseCase: BaseUseCase {
    
    let schoolRepository:SchoolRepository!
    
    init(schoolRepository:SchoolRepository){
        self.schoolRepository = schoolRepository
    }
    
    func buildUseCaseObservable() -> Single<School>{
        return schoolRepository.getSchool()
    }
}
