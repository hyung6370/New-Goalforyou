//
//  HomeViewController.swift
//  AskMe2
//
//  Created by KIM Hyung Jun on 12/31/23.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import FSCalendar

class HomeViewController: UIViewController {
    private let homeView = HomeView(frame: .zero)
    private var homeViewModel = HomeViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = #colorLiteral(red: 0.7766802907, green: 0.4936367869, blue: 0.9485804439, alpha: 1)

        setupLayout()
        setupBinding()
    }
    
    private func setupLayout() {
        view.addSubview(homeView)
        
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        homeView.addButton.rx.tap
            .subscribe(onNext: {
                print("History button tapped")
                self.navigationToAddGoal()
                
            }).disposed(by: disposeBag)

        homeView.settingButton.rx.tap
            .subscribe(onNext: {
                print("Setting button tapped")
            }).disposed(by: disposeBag)

        homeView.logoutButton.rx.tap
            .subscribe(onNext: {
                print("Logout button tapped")
                self.showLogoutCode()
            }).disposed(by: disposeBag)
        
        homeView.calendarView.delegate = self
        homeViewModel.selectedDate
            .subscribe(onNext: { [weak self] date in
                self?.showCalendarModal(for: date)
            }).disposed(by: disposeBag)
    }
    
    private func showCalendarModal(for date: Date) {
        let calendarModal = CalendarModal()
        view.addSubview(calendarModal)
        calendarModal.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func navigationToAddGoal() {
        let addGoalVC = AddGoalViewController()
        navigationController?.pushViewController(addGoalVC, animated: true)
    }

    private func showLogoutCode() {
        let alertView = CustomAlertView()
        alertView.configure(message: "로그아웃 하시겠습니까?", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            do {
                try Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
                alertView.dismiss()
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
        alertView.show(on: self.view)
    }
}

extension HomeViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        homeViewModel.selectDate(date)
    }
}
