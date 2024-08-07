//
//  GlobalFrameTestViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/07/23.
//

import UIKit

class GlobalFrameTestViewController: UIViewController, GlobalFrameTestViewDelegate {
    
    // MARK: - Member
    var globalFrameTestView: GlobalFrameTestView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 25)
        navigationTitleLabel.text = "GlobalFrameTest"
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
        globalFrameTestView = GlobalFrameTestView(frame: SizeConstant.shared.MODELESS_VIEW_FRAME)
        globalFrameTestView?.globalFrameTestViewDelegate = self
        self.view.addSubview(globalFrameTestView!)
    }
    
    
    // MARK: - Delegate(GlobalFrameTestView)
    func nextButtonTapAction() {
        TEST_FRAME_SIZE_BOOL.toggle()
        self.navigationController?.pushViewController(GlobalFrameTestViewController(), animated: true)
    }
}
