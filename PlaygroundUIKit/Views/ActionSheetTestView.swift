//
//  ActionSheetTestView.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2024/11/06.
//

import UIKit

protocol ActionSheetViewDelegate {
    func buttonTapAction(sender: UIButton)
}

class ActionSheetTestView: UIView {
    
    // MARK: - Member
    var delegate: ActionSheetViewDelegate?
    
    let button1: UIButton = UIButton()
    let button2: UIButton = UIButton()
    let button3: UIButton = UIButton()
    let button4: UIButton = UIButton()
    
    
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
        button1.setTitle("Button1", for: .normal)
        button1.setTitleColor(.red, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button1.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        self.addSubview(button1)
        
        button2.setTitle("Button2", for: .normal)
        button2.setTitleColor(.blue, for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button2.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        self.addSubview(button2)
        
        button3.setTitle("Button3", for: .normal)
        button3.setTitleColor(.green, for: .normal)
        button3.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button3.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        self.addSubview(button3)
        
        button4.setTitle("Button4", for: .normal)
        button4.setTitleColor(.orange, for: .normal)
        button4.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button4.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        self.addSubview(button4)
        
        // AutoLayout
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        button4.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            button1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            button2.topAnchor.constraint(equalTo: button1.topAnchor),
            button2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            button3.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 100),
            button3.leadingAnchor.constraint(equalTo: button1.leadingAnchor),
            button4.topAnchor.constraint(equalTo: button3.topAnchor),
            button4.trailingAnchor.constraint(equalTo: button2.trailingAnchor)
        ])
    }
    
    
    // MARK: - Action
    @objc func buttonTapAction(_ sender: UIButton) {
        delegate?.buttonTapAction(sender: sender)
    }
    
}
