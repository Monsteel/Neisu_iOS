//
//  SettingsTableViewReactor.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import ReactorKit
import RxSwift

class SettingsTableViewReactor: Reactor {
    let initialState: State
    
    let deleteSchoolUseCase:DeleteSchoolUseCase
    let deleteAllMealUseCase:DeleteAllMealUseCase
    let insertMealByMonthUseCase:InsertMealByMonthUseCase
    let getSchoolUseCase:GetSchoolUseCase
    
    init(deleteSchoolUseCase:DeleteSchoolUseCase,
         deleteAllMealUseCase:DeleteAllMealUseCase,
         insertMealByMonthUseCase:InsertMealByMonthUseCase,
         getSchoolUseCase:GetSchoolUseCase) {
        self.initialState = State(school: nil,
                                  isLoading: false,
                                  isCompleteReset: false,
                                  isCompleteReload: false,
                                  error: nil)
        
        self.deleteSchoolUseCase = deleteSchoolUseCase
        self.deleteAllMealUseCase = deleteAllMealUseCase
        self.insertMealByMonthUseCase = insertMealByMonthUseCase
        self.getSchoolUseCase = getSchoolUseCase
    }
    
    enum Action {
        case initialize
        case resetApplication
        case reloadMealsData
    }
    
    enum Mutation {
        case setSchool(School?)
        case setLoadingState(Bool)
        case setError(Error)
        case setResetRequestSate(Bool)
        case setReloadRequestSate(Bool)
    }
    
    struct State {
        var school:School?
        var isLoading:Bool
        var isCompleteReset:Bool
        var isCompleteReload:Bool
        var error:Error?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .initialize:
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    getSchoolUseCase.buildUseCaseObservable().asObservable()
                        .map{ Mutation.setSchool($0) }
                        .catchError { Observable.just(Mutation.setError($0)) },
                    Observable.just(Mutation.setLoadingState(false))
                ])
            case .resetApplication:
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    Observable.concat([
                        deleteSchoolUseCase.buildUseCaseObservable().asObservable(),
                        deleteAllMealUseCase.buildUseCaseObservable().asObservable()
                    ]).map { Mutation.setResetRequestSate(true) }
                    .catchError { Observable.just(Mutation.setError($0)) },
                    Observable.just(Mutation.setSchool(nil)),
                    Observable.just(Mutation.setLoadingState(false))
                ])
            case .reloadMealsData:
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    insertMealByMonthUseCase.buildUseCaseObservable(param: InsertMealByMonthUseCase.Param(date: Date()))
                        .asObservable()
                        .map { Mutation.setReloadRequestSate(true) }
                        .catchError { Observable.just(Mutation.setError($0)) },
                    Observable.just(Mutation.setLoadingState(false))
                ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.error = nil
        state.school = nil
        
        switch mutation {
            case .setLoadingState(let isLoading):
                state.isLoading = isLoading
            case .setError(let error):
                state.isCompleteReset = false
                state.isCompleteReload = false
                state.error = error
            case .setResetRequestSate(let isCompleteReset):
                state.isCompleteReset = isCompleteReset
            case .setReloadRequestSate(let isCompleteReload):
                state.isCompleteReload = isCompleteReload
            case .setSchool(let school):
                state.school = school
        }
        return state
    }
}
