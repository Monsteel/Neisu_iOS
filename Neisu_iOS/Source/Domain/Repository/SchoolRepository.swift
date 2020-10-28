//
//  SchoolRepository.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

protocol SchoolRepository {
    func searchSchool(getSchoolRequest: GetSchoolRequest) -> Single<Array<SchoolInfo>>
}
