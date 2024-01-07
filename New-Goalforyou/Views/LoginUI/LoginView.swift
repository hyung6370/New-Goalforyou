//
//  LoginView.swift
//  AskMe2
//
//  Created by KIM Hyung Jun on 12/31/23.
//

import UIKit
import SnapKit
import Then
import Lottie

class LoginView: UIView {
    private let background = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleAspectFill
    }
    
    let backButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "backButton"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let background2 = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 25
    }
    
    private let mainLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Sign In"
        $0.textColor = .black
        $0.font = UIFont(name: "Poppins-Bold", size: 45.0)
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 4
    }
    
    private let semiLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "소셜 로그인을 통해서 'Goal for you' 앱을 시작해보세요!"
        $0.textColor = .black
        $0.font = UIFont(name: "GmarketSansTTFMedium", size: 13.0)
    }
    
    private let semiLabel2 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Sign up with Google or Apple or Kakao."
        $0.textColor = .lightGray
        $0.font = UIFont(name: "Inter-SemiBold", size: 15.0)
    }
    
    let googleButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Logo Google"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageView?.clipsToBounds = true
        $0.adjustsImageWhenHighlighted = false
    }
    
    let appleButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Logo Apple"), for: .normal)
        $0.adjustsImageWhenHighlighted = false
    }
    
    let kakaoButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Logo Kakao"), for: .normal)
        $0.adjustsImageWhenHighlighted = false
    }
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [googleButton, appleButton, kakaoButton]).then {
            $0.axis = .horizontal
            $0.spacing = 10
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        lottieAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(background)
        addSubview(background2)
        
        addSubview(mainLabel)
        addSubview(semiLabel)
        
        addSubview(semiLabel2)
        addSubview(buttonStackView)

        addSubview(backButton)
        
        background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(80)
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        background2.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(350)
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(background2.snp.top).offset(25)
            $0.centerX.equalTo(background2.snp.centerX)
        }
        
        semiLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(background2.snp.centerX)
        }
        
        googleButton.snp.makeConstraints {
            $0.width.height.equalTo(75)
        }
        
        googleButton.imageView?.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        
        appleButton.snp.makeConstraints {
            $0.width.height.equalTo(65)
        }
        
        appleButton.imageView?.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-120)
            $0.centerX.equalToSuperview()
        }
        
        semiLabel2.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func lottieAnimation() {
        let animationView: LottieAnimationView = .init(name: "animation")
        addSubview(animationView)
        
        animationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(300)
            $0.top.equalToSuperview().offset(130)
        }

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
}
