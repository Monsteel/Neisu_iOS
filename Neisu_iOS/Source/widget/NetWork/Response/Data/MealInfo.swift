//
//  Meal.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/14.
//

import Foundation

class MealInfo: Decodable {
    let ATPT_OFCDC_SC_CODE: String
    let ATPT_OFCDC_SC_NM: String
    let SD_SCHUL_CODE: String
    let SCHUL_NM: String
    let MMEAL_SC_CODE: String
    let MMEAL_SC_NM: String
    let MLSV_YMD: Date
    let MLSV_FGR: String
    let DDISH_NM: String
    let ORPLC_INFO: String
    let CAL_INFO: String
    let NTR_INFO: String
    let MLSV_FROM_YMD: String
    let MLSV_TO_YMD: String
}
