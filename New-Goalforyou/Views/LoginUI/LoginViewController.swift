//
//  LoginViewController.swift
//  AskMe2
//
//  Created by KIM Hyung Jun on 12/31/23.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices

class LoginViewController: UIViewController {
    private let loginView = LoginView(frame: .zero)
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        setupLayout()
        setupBinding()
    }

    private func setupLayout() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupBinding() {
        loginView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                print("Button Tapped")
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        loginView.googleButton.rx.tap
            .do(onNext: { _ in
                print("Google login button tapped")
            })
            .subscribe(onNext: { [weak self] in
                self?.loginViewModel.googleLogin()
            }).disposed(by: disposeBag)

        loginViewModel.isLoggedIn.subscribe(onNext: { [weak self] isLoggedIn in
            if isLoggedIn {
                self?.navigationToHome()
            }
        }).disposed(by: disposeBag)

        loginViewModel.errorMessage.subscribe(onNext: { message in
            print(message)
        }).disposed(by: disposeBag)
        
        loginView.appleButton.rx.tap
            .do(onNext: { _ in
                print("Apple login button tapped")
            })
            .subscribe(onNext: { [weak self] in
                self?.startSignInWithAppleFlow()
            }).disposed(by: disposeBag)
        
        loginView.kakaoButton.rx.tap
            .do(onNext: { _ in
                print("Kakao login button tapped")
            })
            .subscribe(onNext: { [weak self] in
                self?.loginViewModel.kakaoLogin()
            }).disposed(by: disposeBag)
    }
    
    private func startSignInWithAppleFlow() {
        print("Starting Apple Sign In Flow")
        loginViewModel.startSignInWithAppleFlow(from: self)
    }
    
    private func navigationToHome() {
        let homeVC = HomeViewController()
        let tabController = TabController() // 탭 컨트롤러 인스턴스 생성
        UIApplication.shared.windows.first?.rootViewController = tabController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("Apple Authorization Completed")
        loginViewModel.handleAuthorization(authorization)
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Authorization Failed: \(error.localizedDescription)")
    }
}
