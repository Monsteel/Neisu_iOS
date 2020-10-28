//
//  BaseDbManager.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 31/07/2020.
//

import Foundation
import RealmSwift


class BaseDbManager {
    private static var realmInstance : Realm!
    
    func getReam() -> Realm! {
        if(BaseDbManager.realmInstance == nil){
            BaseDbManager.realmInstance = try! Realm()
        }
        return BaseDbManager.realmInstance
    }
}
