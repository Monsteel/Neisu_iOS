//
//  MealsViewReactor.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import ReactorKit
import RxSwift

class MealsViewReactor: Reactor {
    let initialState: State
    
    let getMealByMonthUseCase:GetMealByMonthUseCase
    
    init(getMealByMonthUseCase:GetMealByMonthUseCase) {
        self.initialState = State(isLoading: false,
                                  error: nil,
                                  mealsByMonth: [])
        
        self.getMealByMonthUseCase = getMealByMonthUseCase
    }
    
    enum Action {
        case initialize
    }
    
    enum Mutation {
        case setLoadingState(Bool)
        case setError(Error)
        case setMealsByMonth([Meal])
    }
    
    struct State {
        var isLoading:Bool
        var error:Error?
        var mealsByMonth:[Meal]
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .initialize:
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    getMealByMonthUseCase.buildUseCaseObservable(param: GetMealByMonthUseCase.Param(date: Date()))
                        .asObservable()
                        .map { Mutation.setMealsByMonth($0) }
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
                state.error = error
            case .setMealsByMonth(let mealsByMonth):
                state.mealsByMonth = mealsByMonth
        }
        
        return state
    }
}
