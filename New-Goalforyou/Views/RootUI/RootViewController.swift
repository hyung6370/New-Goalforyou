//
//  RootViewController.swift
//  Refactoring-Askme
//
//  Created by KIM Hyung Jun on 1/3/24.
//

import UIKit
import RxSwift
import RxCocoa

class RootViewController: UIViewController {
    private let rootView = RootView(frame: .zero)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        view.backgroundColor = .white

        setupLayout()
        setupBinding()
    }

    private func setupLayout() {
        view.addSubview(rootView)
        
        rootView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        rootView.startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationToLogin()
            }).disposed(by: disposeBag)
    }
    
    private func navigationToLogin() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
