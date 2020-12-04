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
    let getSchoolUseCase:GetSchoolUseCase
    
    init(getMealByMonthUseCase:GetMealByMonthUseCase,
         getSchoolUseCase:GetSchoolUseCase) {
        self.initialState = State(isLoading: false,
                                  error: nil,
                                  mealsByMonth: [])
        
        self.getMealByMonthUseCase = getMealByMonthUseCase
        self.getSchoolUseCase = getSchoolUseCase
    }
    
    enum Action {
        case initialize(Date)
        case selectDate(Date)
    }
    
    enum Mutation {
        case setLoadingState(Bool)
        case setError(Error)
        case setMealsByMonth([Meal])
        case setSchool(School?)
    }
    
    struct State {
        var isLoading:Bool
        var error:Error?
        var mealsByMonth:[Meal]
        var school:School?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .initialize(let date):
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    getSchoolUseCase.buildUseCaseObservable().asObservable()
                        .map{ Mutation.setSchool($0) }
                        .catchError { Observable.just(Mutation.setError($0)) },
                    getMealByMonthUseCase.buildUseCaseObservable(param: GetMealByMonthUseCase.Param(date: date))
                        .asObservable()
                        .map { Mutation.setMealsByMonth($0) }
                        .catchError { Observable.just(Mutation.setError($0)) },
                    Observable.just(Mutation.setLoadingState(false))
                ])
            case .selectDate(let date):
                return Observable.concat([
                    Observable.just(Mutation.setLoadingState(true)),
                    getMealByMonthUseCase.buildUseCaseObservable(param: GetMealByMonthUseCase.Param(date: date))
                        .asObservable()
                        .map { Mutation.setMealsByMonth($0) }
                        .catchError { Observable.just(Mutation.setError($0)) },
                    Observable.just(Mutation.setLoadingState(false))
                ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.error = nil
        state.mealsByMonth.removeAll()
        
        switch mutation {
            case .setLoadingState(let isLoading):
                state.isLoading = isLoading
            case .setError(let error):
                state.error = error
            case .setMealsByMonth(let mealsByMonth):
                state.mealsByMonth = mealsByMonth
            case .setSchool(let school):
                state.school = school
        }
        return state
    }
}
