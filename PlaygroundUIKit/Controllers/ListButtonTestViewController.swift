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
        self.view.backgroundColor = C01_COLOR
        // タイトル設定
        self.title = "ListButton"
        // 画面描画
        viewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Viewload
    func viewLoad() {
        // 画面Viewの生成
        let view = ListButtonTestView()
        view.delegate = self
        listButtonTestView = view
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
    
    func listButtonTapAction() {
        self.navigationController?.pushViewController(ListButtonTestViewController(), animated: true)
    }
}
