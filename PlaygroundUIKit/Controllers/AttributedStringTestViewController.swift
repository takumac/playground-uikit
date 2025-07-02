//
//  AttributedStringTestViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2025/07/03.
//

import UIKit

class AttributedStringTestViewController: UIViewController {
    
    // MARK: - Member
    var attributedStringTestView: AttributedStringTestView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 25)
        navigationTitleLabel.text = "attributedStringTest"
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
        attributedStringTestView = AttributedStringTestView(frame: SizeConstant.shared.MODELESS_VIEW_FRAME)
        self.view.addSubview(attributedStringTestView!)
    }
}
