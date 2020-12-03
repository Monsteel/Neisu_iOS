//
//  ViewController.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/10/07.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    var disposedBag:DisposeBag!
    var getMealByMonthUseCase:GetMealByMonthUseCase!
    
    var searchSchoolUseCase:SearchSchoolUseCase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disposedBag = DisposeBag()
        getMealByMonthUseCase = DependencyProvider().container.resolve(GetMealByMonthUseCase.self)!
        searchSchoolUseCase = DependencyProvider().container.resolve(SearchSchoolUseCase.self)!
        request2()
    }
    
    private func requeset(){
        getMealByMonthUseCase.buildUseCaseObservable(param: GetMealByMonthUseCase.Param(year: 2020, month: 11, agencyCode: "C10", schoolCode: "1234", pIndex: 1))
            .subscribe { response in
                print("LOGLOG")
                dump(response)
            } onError: { error in
                dump(error)
            }.disposed(by: disposedBag)
    }
    
    private func request2(){
        searchSchoolUseCase.buildUseCaseObservable(param: SearchSchoolUseCase.Param(schoolName: "1234", pIndex: 1))
            .subscribe { response in
                print("LOGLOG")
                dump(response)
            } onError: { error in
                dump(error)
            }.disposed(by: disposedBag)
    }
    
    private func getObservable() -> Observable<Void>{
        return Single<Void>.create { single in
            single(.success(Void()))
            return Disposables.create()
        }.asObservable()
    }


}

