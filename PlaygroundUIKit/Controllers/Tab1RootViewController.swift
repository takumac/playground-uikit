//
//  Tab1RootViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2026/01/20.
//

import UIKit

class Tab1RootViewController: UIViewController, Tab1RootViewDelegate {
    // MARK: - Member
    var tab1RootView: Tab1RootView?
    
    
    // MARK: - Init
    
    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // タイトル設定
        self.title = "Tab1"
        // 画面描画
        viewLoad()
    }
    
    
    // MARK: - ViewLoad
    private func viewLoad() {
        // 画面Viewの生成
        let view = Tab1RootView()
        view.delegate = self
        tab1RootView = view
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
    
    
    // MARK: - Delegate(Tab1RootViewDelegate)
    func phpickerButtonTapAction() {
        self.navigationController?.pushViewController(PhPickerTestViewController(), animated: true)
    }
    
    func listButtonButtonTapAction() {
        self.navigationController?.pushViewController(ListButtonTestViewController(), animated: true)
    }
    
    func accordionButtonButtonTapAction() {
        self.navigationController?.pushViewController(AccordionButtonTestViewController(), animated: true)
    }
    
    func pickerTextFieldButtonTapAction() {
        self.navigationController?.pushViewController(PickerTextFieldTestViewController(), animated: true)
    }
    
    func tableViewButtonTapAction() {
        self.navigationController?.pushViewController(TableViewTestViewController(), animated: true)
    }
    
    func radioButtonTapAction() {
        self.navigationController?.pushViewController(RadioButtonTestViewController(), animated: true)
    }
    
    func convertToAttributedStringButtonTapAction() {
        self.navigationController?.pushViewController(ConvertToAttributedStringTestViewController(), animated: true)
    }
    
    func actionSheetButtonTapAction() {
        self.navigationController?.pushViewController(ActionSheetTestViewController(), animated: true)
    }
    
    func attributedStringButtonTapAction() {
        self.navigationController?.pushViewController(AttributedStringTestViewController(), animated: true)
    }
    
    func compositionalLayoutButtonTapAction() {
        self.navigationController?.pushViewController(CompositionalLayoutTestViewController(), animated: true)
    }
    
    func speechBubbleButtonTapAction() {
        self.navigationController?.pushViewController(SpeechBubbleTestViewController(), animated: true)
    }
}
