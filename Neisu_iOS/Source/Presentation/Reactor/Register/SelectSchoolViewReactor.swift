//
//  SelectSchoolViewReactor.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import ReactorKit
import RxSwift

class SelectSchoolViewReactor: Reactor {
    let initialState: State
    
    let searchSchoolUseCase:SearchSchoolUseCase
    
    init(searchSchoolUseCase:SearchSchoolUseCase) {
        self.initialState = State(isLoading: false,
                                  error: nil,
                                  searchResults: [])
        
        self.searchSchoolUseCase = searchSchoolUseCase
    }
    
    enum Action {
        case searchSchool(String, Int)
    }
    
    enum Mutation {
        case setLoadingState(Bool)
        case setError(Error)
        case setSearchResults([School])
    }
    
    struct State {
        var isLoading:Bool
        var error:Error?
        var searchResults:[School]
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case let .searchSchool(schoolName, pIndex):
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    searchSchoolUseCase.buildUseCaseObservable(param: SearchSchoolUseCase.Param(schoolName: schoolName, pIndex: pIndex))
                        .asObservable()
                        .map { Mutation.setSearchResults($0) }
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
                state.searchResults = []
                state.error = error
            case .setSearchResults(let searchResults):
                state.searchResults = searchResults
        }
        return state
    }
}
