//
//  PickerTextFieldTestViewController.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/08/07.
//

import Foundation
import UIKit

class PickerTextFieldTestViewController: UIViewController {
    
    // MARK: - Member
    var pickerTextFieldTestView: PickerTextFieldTestView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 25)
        navigationTitleLabel.text = "pickerTextFieldTest"
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
        pickerTextFieldTestView = PickerTextFieldTestView(frame: SizeConstant.shared.MODELESS_VIEW_FRAME)
        self.view.addSubview(pickerTextFieldTestView!)
    }
}
