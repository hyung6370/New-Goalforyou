//
//  CalendarModal.swift
//  New-Goalforyou
//
//  Created by KIM Hyung Jun on 1/6/24.
//

import UIKit
import SnapKit
import Then

class CalendarModal: UIView {
    private let backgroundView = UIView()
    private let dateLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = UIFont(name: "GmarketSansTTFMedium", size: 15.0)
    }
    private let eventNameField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.font = UIFont(name: "Inter-SemiBold", size: 13.0)
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = true
        $0.attributedPlaceholder = NSAttributedString(string: "새로운 이벤트", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupBackGroundTouch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackGroundTouch() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissAlert() {
        self.removeFromSuperview()
    }
    
    private func setupLayout() {
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        backgroundView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(270)
            $0.height.greaterThanOrEqualTo(150)
        }
        
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(10)
            $0.left.right.equalTo(containerView).inset(20)
        }
        
        containerView.addSubview(eventNameField)
        eventNameField.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.left.right.equalTo(containerView).inset(0)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-5)
            $0.height.equalTo(44)
        }
        
        
    }
}
