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
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // タイトル設定
        self.title = "TableView"
        // 画面描画
        viewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraint()
    }
    
    // MARK: - Viewload
    func viewLoad() {
        // 画面Viewの生成
        let view = TableViewTestView()
        view.delegate = self
        tableViewTestView = view
        self.view.addSubview(view)
        // 画面ViewのAutoLayout
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
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
        view.addConstraint(tableViewHeightConstraint!)
        // Viewの持つテーブルビューの高さの制約を更新
        view.tableView.reloadData()
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
