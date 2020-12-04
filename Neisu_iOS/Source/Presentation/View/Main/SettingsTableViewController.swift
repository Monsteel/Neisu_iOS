//
//  SettingsTableViewController.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class SettingsTableViewController: UITableViewController {
    internal var disposeBag = DisposeBag()
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolAdressLabel: UILabel!
    
    @IBOutlet weak var isShowBreakfastSwitch: UISwitch!
    @IBOutlet weak var isShowLaunchSwitch: UISwitch!
    @IBOutlet weak var isShowDinnerSwitch: UISwitch!
    
    @IBOutlet weak var reloadMealsButton: UIButton!
    @IBOutlet weak var resetAppButton: UIButton!
    
    override func viewDidLoad() {
        reactor = DependencyProvider.shared.container.resolve(SettingsTableViewReactor.self)!
        setupData()
        setupView()
    }
}

extension SettingsTableViewController {
    private func setupData() {
        initialize()
        bindView()
    }
    
    private func initialize() {
        Observable.just(Reactor.Action.initialize)
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
    
    private func bindView() {
        reloadMealsButton.rx.tap
            .map{ Reactor.Action.reloadMealsData }
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
        
        resetAppButton.rx.tap
            .flatMap { UIAlertController.present(in: self,
                                                 title: "모든 데이터를 삭제하시겠습니까?",
                                                 message: "삭제한 데이터는 다시 되돌릴 수 없습니다.",
                                                 style: .actionSheet,
                                                 actions:[
                                                    .action(title: "취소", style: .cancel),
                                                    .action(title: "삭제", style: .destructive)
                                                 ])}
            .filter { $0 == 1 }
            .map { _ in Reactor.Action.resetApplication }
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
}

extension SettingsTableViewController {
    private func setupView() { }
    
    private func moveToRegister() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "registerNaviagtionController")
            self.present(mainViewController, animated: false, completion: nil)
        }
    }
}

extension SettingsTableViewController: StoryboardView {
    func bind(reactor: SettingsTableViewReactor) {
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.startIndicatingActivity() : self.stopIndicatingActivity()
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.isCompleteReset }
            .filter { $0 }
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.moveToRegister()
            }.disposed(by: disposeBag)
        
        reactor.state.map { $0.isCompleteReload }
            .filter { $0 }
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.view.superview?.makeToast("새 급식 불러오기 성공!", duration: 2.0, position: .top)
            }.disposed(by: disposeBag)
        
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
                    self.warningAlert(title: error.localizedDescription,
                                      message: "Reason : \(error.localizedFailureReason ?? "알 수 없음") ")
                }
            }.disposed(by: disposeBag)
    }
}
