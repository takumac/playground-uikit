//
//  Tab2RootView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2026/01/20.
//

import UIKit

protocol Tab2RootViewDelegate: AnyObject {
}


class Tab2RootView: UIView {
    // MARK: - Member
    weak var delegate: Tab2RootViewDelegate?
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        viewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ViewLoad
    private func viewLoad() {
        let label = UILabel()
        label.text = "Tab2RootView"
        label.textAlignment = .center
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
