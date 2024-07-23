//
//  ListButtonTestViewController.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/08/03.
//

import Foundation
import UIKit

class ListButtonTestViewController: UIViewController, ListButtonTestViewDelegate {
    
    // MARK: - Member
    var listButtonTestView: ListButtonTestView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = UIColor.white
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 25)
        navigationTitleLabel.text = "ListButtonTest"
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
        listButtonTestView = ListButtonTestView(frame: SizeConstant.shared.MODELESS_VIEW_FRAME)
        listButtonTestView?.listButtonTestViewDelegate = self
        self.view.addSubview(listButtonTestView!)
    }
    
    func listButtonTapAction() {
        self.navigationController?.pushViewController(ListButtonTestViewController(), animated: true)
    }
}
