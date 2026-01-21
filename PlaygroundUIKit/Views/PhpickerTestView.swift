//
//  PhpickerTestView.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/06/21.
//

import Foundation
import UIKit

protocol PhpickerTestViewDelegate: AnyObject {
    func phpickerButtonTapAction()
}

class PhpickerTestView: UIView {
    
    /// Delegate
    weak var delegate: PhpickerTestViewDelegate?
    
    /// 画像を設定するImageView
    let imageView: UIImageView = UIImageView()
    
    /// PHPickerを呼び出すボタン
    let phpickerButton: UIButton = UIButton()
    
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
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
        
        phpickerButton.setTitle("PHPicker Run", for: .normal)
        phpickerButton.setTitleColor(C02_COLOR, for: .normal)
        phpickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        phpickerButton.sizeToFit()
        phpickerButton.addTarget(self, action: #selector(phpickerButtonTapAction(_:)), for: .touchUpInside)
        
        addSubview(imageView)
        addSubview(phpickerButton)
        
        // AutoLayout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        phpickerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            phpickerButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            phpickerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    
    // MARK: - Action
    @objc func phpickerButtonTapAction(_ sender: UIButton) {
        delegate?.phpickerButtonTapAction()
    }
}
