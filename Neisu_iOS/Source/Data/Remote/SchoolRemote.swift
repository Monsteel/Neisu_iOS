//
//  SchoolRemote.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/28.
//

import RxSwift

class SchoolRemote: BaseRemote<NeisSchoolSearchAPI> {
    func searchSchool(schoolName:String, pIndex:Int) -> Single<Array<School>>{
        return provider.rx.request(.searchSchool(schoolName:schoolName, pIndex:pIndex)).map(SchoolInfoResponse.self, using: decoder)
            .map {
                let statusHeader = $0.head.headSecond.result

                if(statusHeader?.code != "INFO-000"){
                    throw NeisuError.NetWorkError(status: statusHeader?.code ?? "", errorBody: ["message":statusHeader?.message ?? ""])
                }
                
                return $0.row.map { School(schoolName: $0.SCHUL_NM,
                                           schoolNameEnglish: $0.ENG_SCHUL_NM ?? $0.SCHUL_NM,
                                           schoolAdress: $0.ORG_RDNMA,
                                           schoolCode: $0.SD_SCHUL_CODE,
                                           agencyCode: $0.ATPT_OFCDC_SC_CODE) }
            }
    }
}
