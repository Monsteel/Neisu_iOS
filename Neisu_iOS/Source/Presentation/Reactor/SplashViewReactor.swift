//
//  SplashViewReactor.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import ReactorKit
import RxSwift

class SplashViewReactor: Reactor {
    let initialState: State
    
    let getSchoolUseCase:GetSchoolUseCase
    
    init(getSchoolUseCase:GetSchoolUseCase) {
        initialState = State(isLoading: false,
                             isRegister: false,
                             error: nil)
        
        self.getSchoolUseCase = getSchoolUseCase
    }
    
    enum Action {
        case launchApp
    }
    
    enum Mutation {
        case setLoadingState(Bool)
        case setRegisterState(Bool)
        case setError(Error)
    }
    
    struct State {
        var isLoading:Bool
        var isRegister:Bool
        var error:Error?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch  action {
             case .launchApp:
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    getSchoolUseCase.buildUseCaseObservable()
                        .asObservable()
                        .map { _ in true }
                        .map { Mutation.setRegisterState($0) }
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
            case .setRegisterState(let isRegister):
                state.isRegister = isRegister
            case .setError(let error):
                state.isRegister = false
                state.error = error
        }
        
        return state
    }
}
