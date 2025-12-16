//
//  SpeechBubbleTestViewController.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2025/12/16.
//

import UIKit

class SpeechBubbleTestViewController: UIViewController {
    
    // MARK: - Member
    var speechBubbleTestView: SpeechBubbleTestView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 25)
        navigationTitleLabel.text = "Speech Bubble"
        self.navigationItem.titleView = navigationTitleLabel
        
        viewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Viewload
    func viewLoad() {
        speechBubbleTestView = SpeechBubbleTestView(frame: self.view.frame)
        self.view.addSubview(speechBubbleTestView!)
    }
}
