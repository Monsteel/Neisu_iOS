//
//  NeisMealsSearchAPI.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Moya

enum NeisMealsSearchAPI {
    case getMeals(pIndex:Int, agencyCode:String, schoolCode:String, year:Int, month:Int)
}

extension NeisMealsSearchAPI: TargetType {
    
    //EndPoint
    var baseURL: URL {
        return URL(string: Constants.DEFAULT_HOST+"mealServiceDietInfo")!
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
            case let .getMeals(pIndex, agencyCode, schoolCode, year, month):
                return .requestParameters(parameters:["KEY":Constants.KEY,
                                                      "type":"json",
                                                      "pSize" : Constants.INFINITE_SCROLL_LIMIT,
                                                      "pIndex" : pIndex,
                                                      "ATPT_OFCDC_SC_CODE": agencyCode,
                                                      "SD_SCHUL_CODE": schoolCode,
                                                      "MLSV_YMD": Date.from(year: year, month: month, day: 1)!.toString(format: "yyyyMM")],
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
