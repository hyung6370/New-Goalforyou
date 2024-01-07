//
//  AddGoalViewController.swift
//  New-Goalforyou
//
//  Created by KIM Hyung Jun on 1/5/24.
//

import UIKit
import RxSwift
import RxCocoa

class AddGoalViewController: UIViewController {
    private let addGoalView = AddGoalView(frame: .zero)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(addGoalView)
        
        addGoalView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

