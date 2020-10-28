//
//  SchoolRemote.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class SchoolRemote: BaseRemote<NeisSchoolSearchAPI> {
    func searchSchool(getSchoolRequest: GetSchoolRequest) -> Single<Array<SchoolInfo>>{
        return provider.rx.request(.searchSchool(getSchoolRequest: getSchoolRequest)).map(SchoolInfoResponse.self, using: decoder)
            .map {
                let statusHeader = $0.head.headSecond.result

                if(statusHeader?.code != "INFO-000"){
                    throw NetWorkError.Custom(status: statusHeader?.code ?? "", errorBody: ["message":statusHeader?.message ?? ""])
                }else{
                    return $0.row
                }
            }
    }
}
