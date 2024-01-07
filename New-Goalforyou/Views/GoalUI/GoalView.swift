//
//  GoalView.swift
//  New-Goalforyou
//
//  Created by KIM Hyung Jun on 1/5/24.
//

import UIKit
import SnapKit
import Then

class GoalView: UIView {
    private let background = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleAspectFill
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
        
        background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
