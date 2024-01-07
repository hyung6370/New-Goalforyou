//
//  LoginViewModel.swift
//  AskMe2
//
//  Created by KIM Hyung Jun on 12/31/23.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import CryptoKit
import OAuthSwift
import RxKakaoSDKAuth
import RxKakaoSDKUser
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewModel {
    let isLoggedIn = PublishSubject<Bool>()
    let errorMessage = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    fileprivate var currentNonce: String?
    fileprivate var currentState: String?
    
    func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            errorMessage.onNext("Firebase 클라이언트 ID를 가져오는 데 실패했습니다.")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        if let presentingViewController = UIApplication.shared.windows.first?.rootViewController {
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] result, error in
                if let error = error {
                    self?.errorMessage.onNext(error.localizedDescription)
                    return
                }

                guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                    self?.errorMessage.onNext("Google 로그인 실패")
                    return
                }

                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                Auth.auth().signIn(with: credential) { _, error in
                    if let error = error {
                        self?.errorMessage.onNext(error.localizedDescription)
                    } else {
                        self?.isLoggedIn.onNext(true)
                    }
                }
            }
        } else {
            errorMessage.onNext("프레젠팅 뷰 컨트롤러를 찾을 수 없습니다.")
        }
    }
    
    func kakaoLogin() {
        // 카카오 토큰이 존재한다면
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { [weak self] accessTokenInfo, error in
                if let error = error {
                    self?.errorMessage.onNext("카카오톡 토큰 가져오기 에러: \(error.localizedDescription)")
                    self?.kakaoLoginProcess()
                } else {
                    // 토큰 유효성 체크 성공
                    print("로그인 성공")
                    self?.isLoggedIn.onNext(true)
                }
            }
        } else {
            // 토큰이 없는 상태이므로 로그인 과정 수행
            kakaoLoginProcess()
        }
    }

    private func kakaoLoginProcess() {
        if UserApi.isKakaoTalkLoginAvailable() {
            kakaoLoginInApp()
        } else {
            kakaoLoginInWeb()
        }
    }

    private func kakaoLoginInApp() {
        UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
            if let error = error {
                self?.errorMessage.onNext("카카오톡 로그인 에러: \(error.localizedDescription)")
            } else {
                print("카카오톡 로그인 성공")
                if let _ = oauthToken {
                    self?.isLoggedIn.onNext(true)
                    self?.loginInFirebase()
                }
            }
        }
    }

    private func kakaoLoginInWeb() {
        UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
            if let error = error {
                self?.errorMessage.onNext("카카오톡 로그인 에러: \(error.localizedDescription)")
            } else {
                print("카카오톡 로그인 성공")
                if let _ = oauthToken {
                    self?.isLoggedIn.onNext(true)
                    self?.loginInFirebase()
                }
            }
        }
    }

    private func loginInFirebase() {
        UserApi.shared.me() { [weak self] user, error in
            if let error = error {
                self?.errorMessage.onNext("카카오톡 사용자 정보 가져오기 에러: \(error.localizedDescription)")
            } else {
                print("카카오톡 사용자 정보 가져오기 성공")
                self?.isLoggedIn.onNext(true)
            }
        }
    }
    
    func startSignInWithAppleFlow(from viewController: UIViewController) {
        print("ViewModel: Preparing for Apple Sign In")
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = viewController as? ASAuthorizationControllerDelegate
        authorizationController.presentationContextProvider = viewController as? ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
    
    func handleAuthorization(_ authorization: ASAuthorization) {
        print("ViewModel: Handling Apple Authorization")
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                errorMessage.onNext("Invalid state: A login callback was received, but no login request was sent.")
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                errorMessage.onNext("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                errorMessage.onNext("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                if let error = error {
                    self?.errorMessage.onNext(error.localizedDescription)
                    return
                }
                self?.isLoggedIn.onNext(true)
            }
        }
        else {
            print("ViewModel: Apple Authorization Credential is not of expected type")
        }
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func generateState(withLength length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
