//
//  CheckSchoolViewController.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class CheckSchoolViewController: UIViewController {
    internal var disposeBag = DisposeBag()
    
    var selectedSchool:School!
    
    @IBOutlet weak var schoolAdressLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        reactor = DependencyProvider.shared.container.resolve(CheckSchoolViewReactor.self)!
        setupView();
    }
}

extension CheckSchoolViewController {
    private func setupView() {
        setupLable()
        bindView()
    }
    
    private func setupLable() {
        schoolNameLabel.text = selectedSchool.schoolName
        schoolAdressLabel.text = selectedSchool.schoolAdress
    }
    
    private func moveToMain() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            self.present(mainViewController, animated: false, completion: nil)
        }
    }
    
    private func bindView() {
        nextButton.rx.tap
            .map { [weak self] _ in
                guard let self = self else { throw NeisuError.BasicError(message: "self is nil") }
                return Reactor.Action.selectSchool(self.selectedSchool)
            }.bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
}

extension CheckSchoolViewController: StoryboardView {
    func bind(reactor: CheckSchoolViewReactor) {
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.startIndicatingActivity() : self.stopIndicatingActivity()
            }).disposed(by: disposeBag)
        
        
        reactor.state.map { $0.isComplete }
            .filter { $0 }
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.moveToMain()
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
