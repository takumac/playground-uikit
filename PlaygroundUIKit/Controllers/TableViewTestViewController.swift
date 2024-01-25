//
//  TableViewTestViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/01/24.
//

import UIKit

class TableViewTestViewController: UIViewController, TableViewTestViewDelegate {
    
    // MARK: - Member
    var tableViewTestView: TableViewTestView?
    
    var tableViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = UIColor.white
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 25)
        navigationTitleLabel.text = "TableViewTest"
        navigationTitleLabel.adjustsFontSizeToFitWidth = true
        navigationTitleLabel.sizeToFit()
        navigationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        if let navigationBarHeight = navigationController?.navigationBar.bounds.height {
            navigationTitleLabel.heightAnchor.constraint(equalToConstant: navigationBarHeight).isActive = true
        }
        navigationTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: navigationTitleLabel.bounds.width).isActive = true
        self.navigationItem.titleView = navigationTitleLabel
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraint()
    }
    
    // MARK: - Viewload
    func viewLoad() {
        // Viewの生成
        tableViewTestView = TableViewTestView(frame: MODELESS_VIEW_FRAME)
        tableViewTestView?.delegate = self
        
        // テーブルビューの高さに対する制約を生成
        tableViewHeightConstraint = NSLayoutConstraint(
            item: tableViewTestView?.tableView as Any,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1.0,
            constant: 0
        )
        
        // Viewに対して生成した制約を設定
        tableViewTestView?.addConstraint(tableViewHeightConstraint!)
        
        self.view.addSubview(tableViewTestView!)
        
        // Viewの持つテーブルビューの高さの制約を更新
        tableViewTestView?.tableView.reloadData()
        self.updateConstraint()
    }
    
    // 制約を更新する
    func updateConstraint() {
        if tableViewTestView?.tableView.window != nil {
            self.view.layoutIfNeeded()
            self.view.updateConstraints()
            tableViewHeightConstraint?.constant = CGFloat(tableViewTestView?.tableView.contentSize.height ?? 0)
        }
    }
    
    
    // MARK: - Delegate
    func updateTableViewHeight() {
        self.updateConstraint()
    }
}
