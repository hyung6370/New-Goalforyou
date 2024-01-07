//
//  RootView.swift
//  Refactoring-Askme
//
//  Created by KIM Hyung Jun on 1/3/24.
//

import UIKit
import SnapKit
import Then

class RootView: UIView {
    private let background = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Goal For you"
        $0.textColor = .black
        $0.font = UIFont(name: "Poppins-Bold", size: 40.0)
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 4
    }
    
    private let mainLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "이루고 싶은 목표를"
        $0.textColor = .black
        $0.font = UIFont(name: "GmarketSansTTFLight", size: 22.0)
    }
    
    private let mainLabel2 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "달성하도록 도와주는"
        $0.textColor = .black
        $0.font = UIFont(name: "GmarketSansTTFLight", size: 22.0)
    }
    
    private let semiLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "This project is a service that helps you plan and achieve your personal goals. Make your goal come true through Goal for you!"
        $0.textColor = .black
        $0.textAlignment = .justified
        $0.numberOfLines = 0
        $0.font = UIFont(name: "Inter-Regular", size: 11.0)
    }
    
    private let startButtonView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.5810193419, green: 0.1059236303, blue: 0.7124008536, alpha: 0.5166082319)
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    let startButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.5791729689, green: 0.1078030542, blue: 0.7114301324, alpha: 1)
        $0.setTitle(" Start planning", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 15.0)
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let bottomLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "This 'New-Goalforyou service is the development and reconstruction of an existing project, Goal for You. For more information on this project, see .See the https://github.com/hyung6370/goal-for-you-app' link!"
        $0.textColor = .black
        $0.textAlignment = .justified
        $0.numberOfLines = 0
        $0.font = UIFont(name: "Inter-Regular", size: 11.0)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(background)
        addSubview(titleLabel)
        addSubview(mainLabel)
        addSubview(mainLabel2)
        addSubview(semiLabel)
        
        addSubview(startButtonView)
        addSubview(startButton)
        addSubview(bottomLabel)
        
        background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(40)
        }
        
        mainLabel2.snp.makeConstraints {
            $0.leading.equalTo(mainLabel)
            $0.top.equalTo(mainLabel.snp.bottom).offset(7)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(mainLabel2)
            $0.top.equalTo(mainLabel2.snp.bottom).offset(7)
        }
        
        semiLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.width.equalTo(320)
        }
        
        startButtonView.snp.makeConstraints {
            $0.bottom.equalTo(bottomLabel.snp.top).offset(-10)
            $0.leading.equalTo(bottomLabel)
            $0.width.height.equalTo(65)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(bottomLabel.snp.top).offset(-10)
            $0.leading.equalTo(startButtonView.snp.leading).offset(25)
            $0.width.equalTo(180)
            $0.height.equalTo(50)
        }
        
        bottomLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-150)
            $0.leading.equalToSuperview().offset(40)
            $0.width.equalTo(320)
        }
    }
}
