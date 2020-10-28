//
//  NeisSchoolSearchAPI.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 18/08/2020.
//

import Moya

enum NeisSchoolSearchAPI {
    case searchSchool(getSchoolRequest:GetSchoolRequest)
}

extension NeisSchoolSearchAPI: TargetType {
    
    //EndPoint
    var baseURL: URL {
        return URL(string: Constants.DEFAULT_HOST+"schoolInfo")!
    }
    
    //서버의 도메인 뒤에 추가 될 Path (일반적으로 API)
    var path: String {
        return ""
    }
    
    //HTTP method (GET, POST, …)
    var method: Method {
        return .get
    }
    
    //테스트용 Mock Data
    var sampleData: Data {
        return Data()
    }
    
    //리퀘스트에 사용되는 파라미터 설정
    var task: Task {
        switch self {
            case let .searchSchool(getSchoolRequest):
                return .requestParameters(parameters:["KEY":Constants.KEY,
                                                      "type":"json",
                                                      "pIndex": getSchoolRequest.pIndex,
                                                      "pSize" : Constants.INFINITE_SCROLL_LIMIT,
                                                      "SCHUL_NM": getSchoolRequest.schoolName],
                                          encoding: URLEncoding.queryString)
        }
    }
    
    //허용할 response의 타입
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        return nil
    }
}
