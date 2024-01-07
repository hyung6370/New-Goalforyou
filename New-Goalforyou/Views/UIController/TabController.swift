//
//  TabController.swift
//  New-Goalforyou
//
//  Created by KIM Hyung Jun on 1/5/24.
//

import UIKit
import SnapKit
import Then

class TabController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.delegate = self
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        vc1.tabBarItem.image = UIImage(named: "home")
        
        let vc2 = UINavigationController(rootViewController: GoalViewController())
        vc2.tabBarItem.image = UIImage(named: "goal")
        
        let vc3 = UINavigationController(rootViewController: MypageViewController())
        vc3.tabBarItem.image = UIImage(named: "user")
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        self.tabBar.clipsToBounds = true
        self.tabBar.tintColor = .black
        
        self.tabBar.backgroundColor = .white
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.layer.masksToBounds = true

        setViewControllers([vc1, vc2, vc3], animated: false)
    }
}
