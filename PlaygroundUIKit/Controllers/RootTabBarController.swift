//
//  RootTabBarController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2026/01/18.
//

import UIKit

class RootTabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: - Member
    
    
    // MARK: - Init
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoad()
    }
    
    
    // MARK: - ViewLoad
    private func viewLoad() {
        let tab1RootVC = Tab1RootViewController()
        tab1RootVC.tabBarItem = UITabBarItem(title: "Tab1", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let tab2RootVC = Tab2RootViewController()
        tab2RootVC.tabBarItem = UITabBarItem(title: "Tab2", image: UIImage(systemName: "person.fill"), tag: 1)
        
        let tab1NavVC = UINavigationController(rootViewController: tab1RootVC)
        let tab2NavVC = UINavigationController(rootViewController: tab2RootVC)
        
        self.viewControllers = [tab1NavVC, tab2NavVC]
        self.delegate = self
    }
    
}
