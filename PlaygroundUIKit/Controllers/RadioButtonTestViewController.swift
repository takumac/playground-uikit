//
//  RadioButtonTestViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/03/01.
//

import UIKit


class RadioButtonTestViewController: UIViewController, RadioButtonTestViewDelegate {
    
    // MARK: - Member
    var radioButtonTestView: RadioButtonTestView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = UIColor.white
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 25)
        navigationTitleLabel.text = "RadioButtonTest"
        navigationTitleLabel.adjustsFontSizeToFitWidth = true
        navigationTitleLabel.sizeToFit()
        navigationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        if let navigationBarHeight = navigationController?.navigationBar.bounds.height {
            navigationTitleLabel.heightAnchor.constraint(equalToConstant: navigationBarHeight).isActive = true
        }
        navigationTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: navigationTitleLabel.bounds.width).isActive = true
        self.navigationItem.titleView = navigationTitleLabel
        
        viewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Viewload
    func viewLoad() {
        radioButtonTestView = RadioButtonTestView(frame: MODELESS_VIEW_FRAME)
        radioButtonTestView?.radioButtonTestViewDelegate = self
        self.view.addSubview(radioButtonTestView!)
    }
    
    
    // MARK: - Delegate(RadioButtonTestViewDelegate)
    func radioButton1TapAction() {
    }
}
