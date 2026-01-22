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
        // タイトル設定
        self.title = "ActionSheet"
        // 画面描画
        viewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Viewload
    func viewLoad() {
        // 画面Viewの生成
        let view = ActionSheetTestView()
        view.delegate = self
        actionSheetTestView = view
        self.view.addSubview(view)
        // 画面ViewのAutoLayout
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    
    // MARK: - Delegate(ActionSheetTestView)
    func buttonTapAction(sender: UIButton) {
        let actionSheet: UIAlertController = UIAlertController(title: nil, message: "action sheet", preferredStyle: .actionSheet)
        actionSheet.popoverPresentationController?.sourceView = sender.superview
        actionSheet.popoverPresentationController?.sourceRect = sender.frame
        
        actionSheet.addAction(UIAlertAction(title: "edit", style: .default))
        actionSheet.addAction(UIAlertAction(title: "copy", style: .default))
        actionSheet.addAction(UIAlertAction(title: "delete", style: .destructive))
        if #unavailable(iOS 26.0) {
            actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel))
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }

}
