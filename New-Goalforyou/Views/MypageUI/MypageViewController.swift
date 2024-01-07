//
//  MypageViewController.swift
//  New-Goalforyou
//
//  Created by KIM Hyung Jun on 1/5/24.
//

import UIKit
import RxSwift
import RxCocoa

class MypageViewController: UIViewController {
    private let mypageView = MypageView(frame: .zero)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(mypageView)
        
        mypageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
