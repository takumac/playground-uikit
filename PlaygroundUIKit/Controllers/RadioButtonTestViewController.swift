//
//  RadioButtonTestViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/03/01.
//

import UIKit


class RadioButtonTestViewController: UIViewController, RadioButtonTestViewDelegate {
    
    // MARK: - Member
    var radioButtonTestView: RadioButtonTestView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // タイトル設定
        self.title = "RadioButton"
        // 画面描画
        viewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Viewload
    func viewLoad() {
        // 画面Viewの生成
        let view = RadioButtonTestView()
        view.delegate = self
        radioButtonTestView = view
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
    
    
    // MARK: - Delegate(RadioButtonTestViewDelegate)
    func radioButton1TapAction() {
    }
}
