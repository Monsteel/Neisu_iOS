//
//  CheckSchoolViewReactor.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import ReactorKit
import RxSwift

class CheckSchoolViewReactor: Reactor {
    let initialState: State
    
    let insertSchoolUseCase:InsertSchoolUseCase
    
    init(insertSchoolUseCase:InsertSchoolUseCase) {
        self.initialState = State(isLoading: false,
                                  isComplete: false,
                                  error: nil)
        
        self.insertSchoolUseCase = insertSchoolUseCase
    }
    
    enum Action {
        case selectSchool(School)
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
            case .selectSchool(let school):
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    insertSchoolUseCase.buildUseCaseObservable(param: InsertSchoolUseCase.Param(school: school))
                        .asObservable()
                        .map { true }
                        .map { Mutation.setRequestSate($0) }
                        .catchError { Observable.just(Mutation.setError($0)) },
                    Observable.just(Mutation.setLoadingState(false))
                ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.error = nil
        
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
