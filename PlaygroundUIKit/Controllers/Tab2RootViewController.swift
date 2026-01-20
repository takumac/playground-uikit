//
//  Tab2RootViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2026/01/20.
//

import UIKit

class Tab2RootViewController: UIViewController, Tab2RootViewDelegate {
    // MARK: - Member
    var tab2RootView: Tab2RootView?
    
    // MARK: - Init
    
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // タイトル設定
        self.title = "Tab2"
        // 画面描画
        viewLoad()
    }
    
    
    // MARK: - ViewLoad
    private func viewLoad() {
        // 画面Viewの生成
        let view = Tab2RootView()
        view.delegate = self
        tab2RootView = view
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
}
