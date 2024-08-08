//
//  HTMLtoAttributedStringTestViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/08/07.
//

import UIKit

class ConvertToAttributedStringTestViewController: UIViewController {
    
    // MARK: - Member
    var convertToAttributedStringTestView: ConvertToAttributedStringTestView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 20)
        navigationTitleLabel.text = "ConvertToAttributedString"
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
        convertToAttributedStringTestView = ConvertToAttributedStringTestView(frame: SizeConstant.shared.MODELESS_VIEW_FRAME)
        self.view.addSubview(convertToAttributedStringTestView!)
    }
    
}
