//
//  ActionSheetTestViewController.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2024/11/06.
//

import UIKit

class ActionSheetTestViewController: UIViewController, ActionSheetViewDelegate {
    
    // MARK: - Member
    var actionSheetTestView: ActionSheetTestView?

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 20)
        navigationTitleLabel.text = "ActionSheet"
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
        actionSheetTestView = ActionSheetTestView(frame: SizeConstant.shared.MODELESS_VIEW_FRAME)
        actionSheetTestView?.delegate = self
        self.view.addSubview(actionSheetTestView!)
    }
    
    
    // MARK: - Delegate(ActionSheetTestView)
    func buttonTapAction(sender: UIButton) {
        let actionSheet: UIAlertController = UIAlertController(title: nil, message: "action sheet", preferredStyle: .actionSheet)
        actionSheet.popoverPresentationController?.sourceView = sender.superview
        actionSheet.popoverPresentationController?.sourceRect = sender.frame
        
        actionSheet.addAction(UIAlertAction(title: "edit", style: .default))
        actionSheet.addAction(UIAlertAction(title: "copy", style: .default))
        actionSheet.addAction(UIAlertAction(title: "delete", style: .destructive))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel))
        
        self.present(actionSheet, animated: true, completion: nil)
    }

}
