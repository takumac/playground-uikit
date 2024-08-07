//
//  PhpickerTestView.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/06/21.
//

import Foundation
import UIKit

protocol PhpickerTestViewDelegate {
    func phpickerButtonTapAction()
}

class PhpickerTestView: UIView {
    
    /// Delegate
    var phpickerTestViewDelegate: PhpickerTestViewDelegate?
    
    /// 画像を設定するImageView
    let imageView: UIImageView = UIImageView()
    
    /// PHPickerを呼び出すボタン
    let phpickerButton: UIButton = UIButton()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLoad
    func viewLoad() {
        imageView.backgroundColor = .lightGray
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        self.addSubview(imageView)
        
        phpickerButton.setTitle("PHPicker Run", for: .normal)
        phpickerButton.setTitleColor(C02_COLOR, for: .normal)
        phpickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        phpickerButton.sizeToFit()
        phpickerButton.addTarget(self, action: #selector(phpickerButtonTapAction(_:)), for: .touchUpInside)
        self.addSubview(phpickerButton)
        
        // AutoLayout
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        phpickerButton.translatesAutoresizingMaskIntoConstraints = false
        phpickerButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        phpickerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    
    // MARK: - Action
    @objc func phpickerButtonTapAction(_ sender: UIButton) {
        phpickerTestViewDelegate?.phpickerButtonTapAction()
    }
}
