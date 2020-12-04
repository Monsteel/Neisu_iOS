//
//  SelectSchoolViewController.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class SelectSchoolViewController: UIViewController {
    internal var disposeBag = DisposeBag()
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var selectedSchool:School! {
        didSet {
            (selectedSchool != nil) ? enableNextButton() : disableNextButton()
        }
    }
    
    override func viewDidLoad() {
        reactor = DependencyProvider.shared.container.resolve(SelectSchoolViewReactor.self)!
        setupView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let checkSchoolViewController = segue.destination as? CheckSchoolViewController {
            checkSchoolViewController.selectedSchool = selectedSchool
        }
    }
}

extension SelectSchoolViewController: StoryboardView {
    func bind(reactor: SelectSchoolViewReactor) {
        reactor.state.map{ $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.startIndicatingActivity() : self.stopIndicatingActivity()
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.searchResults }
            .bind(to: searchResultsTableView.rx.items(cellIdentifier: "searchResultItem", cellType: SearchResultCell.self)) { row, element, cell in
                cell.setupData(school: element)
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
                        case .NetWorkError(let message, _):
                            errorMsg = message
                    }
                    self.view.makeToast(errorMsg, duration: 2.0, position: .top)
                }else if let error = error.element as? NSError {
                    if(error.domain == "Moya.MoyaError") { return }
                    self.warningAlert(title: error.localizedDescription,
                                      message: "Reason : \(error.localizedFailureReason ?? "알 수 없음") ")
                }
            }.disposed(by: disposeBag)
    }
}

//MARK: View settings method
extension SelectSchoolViewController {
    private func setupView() {
        bindView()
    }
    
    private func bindView() {
        searchField.rx.controlEvent(.editingChanged)
            .map { [weak self] _ in
                guard let self = self else { throw NeisuError.BasicError(message: "self is nil") }
                return Reactor.Action.searchSchool(self.searchField.text ?? "", 1)
            }.bind(to: reactor!.action)
            .disposed(by: disposeBag)
        
        searchButton.rx.tap
            .map { [weak self] _ in
                guard let self = self else { throw NeisuError.BasicError(message: "self is nil") }
                return Reactor.Action.searchSchool(self.searchField.text ?? "", 1)
            }.bind(to: reactor!.action)
            .disposed(by: disposeBag)
        
        searchResultsTableView.rx.itemSelected
            .subscribe { [weak self] indexPath in
                guard let self = self else { return }
                guard let index = indexPath.element else { return }
                guard let selectedSchool = try? self.searchResultsTableView.rx.model(at: index ) as School else { return }
                
                self.selectedSchool = selectedSchool
            }.disposed(by: disposeBag)
    }
    
    private func moveToMain() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            self.present(mainViewController, animated: false, completion: nil)
        }
    }
    
    private func enableNextButton(){
        nextButton.isEnabled = true
        nextButton.backgroundColor = UIColor.systemBlue
    }
    
    private func disableNextButton(){
        nextButton.isEnabled = false
        nextButton.backgroundColor = UIColor.systemGray4
    }
    
    private func moveToRegister() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "registerNaviagtionController")
            self.present(mainViewController, animated: false, completion: nil)
        }
    }
}

