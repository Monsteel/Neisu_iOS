//
//  SplashViewController.swift
//  Neisu_iOS
//
//  Created by Dev.Young on 2020/12/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class SplashViewController: UIViewController {
    internal var disposeBag = DisposeBag()
    
    override func viewDidLoad(){
        reactor = DependencyProvider.shared.container.resolve(SplashViewReactor.self)!
        setupView();
        setupData();
    }
}

extension SplashViewController: StoryboardView {
    func bind(reactor: SplashViewReactor) {
        reactor.state.map{ $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.startIndicatingActivity() : self.stopIndicatingActivity()
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.isRegister }
            .filter { $0 != nil}
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isRegister in
                guard let self = self else { return }
                isRegister! ? self.moveToMain() : self.moveToRegister()
            }).disposed(by: disposeBag)
    }
}

//MARK: View settings method
extension SplashViewController {
    private func setupView() { }
    
    private func moveToMain() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            self.present(mainViewController, animated: false, completion: nil)
        }
    }
    
    private func moveToRegister() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "registerNaviagtionController")
            self.present(mainViewController, animated: false, completion: nil)
        }
    }
}

//MARK: Data settings method
extension SplashViewController {
    private func setupData() {
        launch();
    }
    
    private func launch() {
        Observable.just(Reactor.Action.launchApp)
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
}
