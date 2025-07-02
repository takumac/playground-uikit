//
//  RootViewController.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/06/21.
//

import Foundation
import UIKit

class RootViewController: UIViewController, RootViewDelegate {
    
    // MARK: Member
    var rootView: RootView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 25)
        navigationTitleLabel.text = "Root"
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
        rootView = RootView(frame: SizeConstant.shared.MODELESS_VIEW_FRAME)
        rootView?.rootViewDelegate = self
        self.view.addSubview(rootView!)
    }
    
    
    // MARK: - Delegate(RootViewDelegate)
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
    
    func globalFrameButtonTapAction() {
        self.navigationController?.pushViewController(GlobalFrameTestViewController(), animated: true)
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
    
}
