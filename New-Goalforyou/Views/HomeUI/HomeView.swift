//
//  HomeView.swift
//  AskMe2
//
//  Created by KIM Hyung Jun on 12/31/23.
//

import UIKit
import SnapKit
import Then
import FSCalendar

class HomeView: UIView, FSCalendarDelegate {
    private let background = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Goal for you!"
        $0.textColor = .black
        $0.font = UIFont(name: "Poppins-Bold", size: 30.0)
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 4
    }
    
    let addButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "add"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }

    let settingButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Settings"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }

    let logoutButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Logout"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addButton, settingButton, logoutButton]).then {
            $0.axis = .horizontal
            $0.spacing = 20
        }
        return stackView
    }()
    
    private let mainLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "My Calendar"
        $0.textColor = #colorLiteral(red: 0.9247999787, green: 0.4382409751, blue: 0.5115415454, alpha: 1)
        $0.font = UIFont(name: "GmarketSansTTFMedium", size: 19.0)
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 4
    }
   
    lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
    }()
    
    let addGoalButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private let todoLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "할 일 목록"
        $0.textColor = .black
        $0.font = UIFont(name: "GmarketSansTTFMedium", size: 19.0)
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(background)
        addSubview(titleLabel)
        addSubview(buttonStackView)
        addSubview(mainLabel)
        addSubview(calendarView)
        addSubview(todoLabel)

        background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-22)
        }
        
        addButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        settingButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        logoutButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-13)
        }
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(30)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(320)
        }
        
        todoLabel.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom)
            $0.leading.equalTo(calendarView.snp.leading)
        }
    }
    
    private func setCalendar() {
        calendarView.delegate = self
        calendarView.swipeToChooseGesture.isEnabled = true
        calendarView.allowsMultipleSelection = true
        calendarView.scrollDirection = .vertical
    }
}
