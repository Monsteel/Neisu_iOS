//
//  MealsViewController.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class MealsViewController: UIViewController {
    internal var disposeBag = DisposeBag()
    
    @IBOutlet weak var currentDatePicker: UIDatePicker!
    
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var lunchLabel: UILabel!
    @IBOutlet weak var dinnerLabel: UILabel!
    
    @IBOutlet weak var breakfastCardView: CardView!
    @IBOutlet weak var lunchCardView: CardView!
    @IBOutlet weak var dinnerCardView: CardView!
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolAdressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = DependencyProvider().container.resolve(MealsViewReactor.self)!
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupData()
    }
}

//MARK: View settings method
extension MealsViewController {
    private func setupView() {
        setAccent()
        bindView()
    }
    
    private func setAccent() {
        let now = Date()
        let isNow = currentDatePicker.date.equalsDate(date: now)
        
        //아침
        breakfastCardView.backgroundColor = (now.after(Date.from(hour: 06, minute: 20)!) &&
                                             now.before(Date.from(hour: 08, minute: 20)!) &&
                                             isNow) ? UIColor.systemYellow : UIColor.systemBackground
        
        //점심
        lunchCardView.backgroundColor = (now.after(Date.from(hour: 08, minute: 20)!) &&
                                         now.before(Date.from(hour: 13, minute: 20)!) &&
                                         isNow) ? UIColor.systemTeal : UIColor.systemBackground
        
        //저녁
        dinnerCardView.backgroundColor = (now.after(Date.from(hour: 13, minute: 20)!) &&
                                          now.before(Date.from(hour: 19, minute: 10)!) &&
                                          isNow) ? UIColor.systemPurple : UIColor.systemBackground
    }
    
    private func bindView() {
        currentDatePicker.rx.controlEvent(.valueChanged)
            .map { [weak self] _ in
                guard let self = self else { throw NeisuError.BasicError(message: "self is nil") }
                return Reactor.Action.selectDate(self.currentDatePicker.date)
            }.bind(to: reactor!.action )
            .disposed(by: disposeBag)
    }
}

//MARK: Data settings method
extension MealsViewController {
    private func setupData() {
        initialize(date: self.currentDatePicker.date)
    }
    
    private func getNewMeals(date: Date) {
        Observable.just(Reactor.Action.selectDate(date))
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
    
    private func initialize(date: Date) {
        Observable.just(Reactor.Action.initialize(date))
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
}

extension MealsViewController: StoryboardView {
    func bind(reactor: MealsViewReactor) {
        reactor.state.map{ $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.startIndicatingActivity() : self.stopIndicatingActivity()
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.mealsByMonth }
            .filter{ !($0.isEmpty) }
            .map { [weak self] mealsByMonth -> Meal? in
                guard let self = self else { return .none }
                return mealsByMonth.filter { $0.getDate().equalsDate(date: self.currentDatePicker.date) }.first
            }.map{ $0?.breakfast ?? "" }
            .map { $0.isEmpty ? "급식이 없습니다." : $0 }
            .bind(to: breakfastLabel.rx.text )
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.mealsByMonth }
            .filter{ !($0.isEmpty) }
            .map { [weak self] mealsByMonth -> Meal? in
                guard let self = self else { return .none }
                return mealsByMonth.filter { $0.getDate().equalsDate(date: self.currentDatePicker.date) }.first
            }.map{ $0?.lunch ?? "" }
            .map { $0.isEmpty ? "급식이 없습니다." : $0 }
            .bind(to: lunchLabel.rx.text )
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.mealsByMonth }
            .filter{ !($0.isEmpty) }
            .map { [weak self] mealsByMonth -> Meal? in
                guard let self = self else { return .none }
                return mealsByMonth.filter { $0.getDate().equalsDate(date: self.currentDatePicker.date) }.first
            }.map{ $0?.dinner ?? "" }
            .map { $0.isEmpty ? "급식이 없습니다." : $0 }
            .bind(to: dinnerLabel.rx.text )
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.school }
            .filter { $0 != nil }
            .subscribe { [weak self] school in
                guard let self = self else { return }
                self.schoolNameLabel.text = school.element!!.schoolName
                self.schoolAdressLabel.text = school.element!!.schoolAdress
            }.disposed(by: disposeBag)
        
        reactor.state.map { $0.error }
            .filter { $0 != nil }
            .subscribe { [weak self] error in
                guard let self = self else { return }

                var errorMsg = ""

                if let error = error.element as? NeisuError {
                    switch error {
                        case .BasicError(let message):
                            errorMsg = message
                        case .DataBaseError(let message, _):
                            errorMsg = message
                        case .NetWorkError(_, let leterrorBody):
                            errorMsg = leterrorBody["message"] as! String
                    }
                    self.view.superview?.makeToast(errorMsg, duration: 2.0, position: .top)
                }else if let error = error.element as? NSError {
                    if(error.domain == "Moya.MoyaError") { return }
                    self.warningAlert(title: error.localizedDescription,
                                      message: "Reason : \(error.localizedFailureReason ?? "알 수 없음") ")
                }
            }.disposed(by: disposeBag)
    }
}
