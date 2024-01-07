//
//  HistoryViewController.swift
//  AskMe2
//
//  Created by KIM Hyung Jun on 1/2/24.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController {
    private let historyView = HistoryView(frame: .zero)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(historyView)
        
        historyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
