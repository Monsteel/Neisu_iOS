//
//  SchoolDataSource.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class SchoolDataSource: BaseDataSource<SchoolRemote, Any?> {
    func searchSchool(getSchoolRequest: GetSchoolRequest) -> Single<Array<SchoolInfo>>{
        return remote.searchSchool(getSchoolRequest: getSchoolRequest)
    }
}
