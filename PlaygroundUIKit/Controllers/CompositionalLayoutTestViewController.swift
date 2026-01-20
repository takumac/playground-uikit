//
//  CompositionalLayoutTestViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2025/07/08.
//

import UIKit

class CompositionalLayoutTestViewController: UIViewController {
    
    // MARK: - Member
    var compositionalLayoutTestView: CompositionalLayoutTestView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // タイトル設定
        self.title = "Compositional Layout"
        // 画面描画
        viewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - ViewLoad
    func viewLoad() {
        // 画面Viewの生成
        let view = CompositionalLayoutTestView()
        compositionalLayoutTestView = view
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
