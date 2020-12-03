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
    
    init(deleteSchoolUseCase:DeleteSchoolUseCase,
         deleteAllMealUseCase:DeleteAllMealUseCase,
         insertMealByMonthUseCase:InsertMealByMonthUseCase) {
        self.initialState = State(isLoading: false,
                                  isComplete: false,
                                  error: nil)
        
        self.deleteSchoolUseCase = deleteSchoolUseCase
        self.deleteAllMealUseCase = deleteAllMealUseCase
        self.insertMealByMonthUseCase = insertMealByMonthUseCase
    }
    
    enum Action {
        case resetApplication
        case resetMealsData
    }
    
    enum Mutation {
        case setLoadingState(Bool)
        case setError(Error)
        case setRequestSate(Bool)
    }
    
    struct State {
        var isLoading:Bool
        var isComplete:Bool
        var error:Error?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .resetApplication:
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    Observable.concat([
                        deleteSchoolUseCase.buildUseCaseObservable().asObservable(),
                        deleteAllMealUseCase.buildUseCaseObservable().asObservable()
                    ]).map { Mutation.setRequestSate(true) }
                    .catchError { Observable.just(Mutation.setError($0)) },
                    Observable.just(Mutation.setLoadingState(false))
                ])
            case .resetMealsData:
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    insertMealByMonthUseCase.buildUseCaseObservable(param: InsertMealByMonthUseCase.Param(date: Date()))
                        .asObservable()
                        .map { Mutation.setRequestSate(true) }
                        .catchError { Observable.just(Mutation.setError($0)) },
                    Observable.just(Mutation.setLoadingState(false))
                ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
            case .setLoadingState(let isLoading):
                state.isLoading = isLoading
            case .setError(let error):
                state.isComplete = false
                state.error = error
            case .setRequestSate(let isComplete):
                state.isComplete = isComplete
        }
        return state
    }
}
