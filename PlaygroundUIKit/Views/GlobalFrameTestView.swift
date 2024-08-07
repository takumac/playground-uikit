//
//  GlobalFrameTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/07/23.
//

import UIKit

protocol GlobalFrameTestViewDelegate {
    func nextButtonTapAction()
}


class GlobalFrameTestView: UIView {
    
    // MARK: - Member
    /// Delegate
    var globalFrameTestViewDelegate: GlobalFrameTestViewDelegate?
    
    let frameView: UIView = UIView()
    let nextButton: UIButton = UIButton()
    
    
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
        frameView.backgroundColor = .red
        
        // SizeConstantの中のTEST_FRAME_SIZEを
        // ・単純な変数として定義した場合
        // ・シングルトンクラスのストアドプロパティとして定義した場合
        // 上記2つの場合の挙動の違いについて確認する
        // 単純な変数として定義した場合は、一度値が設定された後に状態が変わっても、値が更新されることはない
        // ストアドプロパティの場合は、一度値が設定された後に状態が変わると、その状態に合わせて値が更新される
//        frameView.frame = TEST_FRAME_SIZE
        frameView.frame = SizeConstant.shared.TEST_FRAME_SIZE
        
        nextButton.setTitle("next", for: .normal)
        nextButton.setTitleColor(C02_COLOR, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        nextButton.sizeToFit()
        nextButton.addTarget(self, action: #selector(nextButtonTapAction(_:)), for: .touchUpInside)
        
        self.addSubview(frameView)
        self.addSubview(nextButton)
        
        
        // AutoLayout
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.widthAnchor.constraint(equalToConstant: nextButton.frame.width).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: nextButton.frame.height).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    // MARK: - Action
    @objc func nextButtonTapAction(_ sender: UIButton) {
        globalFrameTestViewDelegate?.nextButtonTapAction()
    }
    
}
