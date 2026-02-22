//
//  ListButtonTestView.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/08/03.
//

import Foundation
import UIKit

protocol ListButtonTestViewDelegate: AnyObject {
    func listButtonTapAction()
}

class ListButtonTestView: UIView {
    
    weak var delegate: ListButtonTestViewDelegate?
    
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
        let listButtonText: UILabel = UILabel()
        listButtonText.text = "あいうえお"
        listButtonText.numberOfLines = 0
        listButtonText.lineBreakMode = .byCharWrapping
        listButtonText.isUserInteractionEnabled = false
        let listButtonView: UIView = UIView()
        listButtonView.isUserInteractionEnabled = false
        listButtonView.addSubview(listButtonText)
        listButtonText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listButtonText.topAnchor.constraint(equalTo: listButtonView.topAnchor, constant: 16),
            listButtonText.bottomAnchor.constraint(equalTo: listButtonView.bottomAnchor, constant: -16),
            listButtonText.leadingAnchor.constraint(equalTo: listButtonView.leadingAnchor, constant: 12),
            listButtonText.trailingAnchor.constraint(equalTo: listButtonView.trailingAnchor)
        ])
        
        let listButton = ListButton(
            contentView: listButtonView,
            borderColor: .lightGray,
            target: self,
            action: #selector(listButtonTapAction)
        )
        listButton.setAutoLayout(imageViewPaddingRight: 12)
        addSubview(listButton)
        
        // AutoLayout
        listButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            listButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            listButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc func listButtonTapAction(_ sender: UIButton) {
        delegate?.listButtonTapAction()
    }
    
}


class ListButton: UIControl {
    
    // MARK: - Member
    var contentView: UIView?
    let imageView: UIImageView = UIImageView()
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    
    
    // MARK: - ハイライト用のUIの変数と、ハイライトに必要なオーバーライド
    var highlightView: UIView = UIView()

    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.05, animations: {
                    self.highlightView.alpha = 0.5
                })
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.highlightView.alpha = 0.0
                })
            }
        }
    }
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// 引数付きinit
    /// - Parameters:
    ///   - contentView: ボタン内部に設定するView
    ///   - borderColor: 枠線の色
    ///   - borderWidth: 枠線の太さ
    ///   - highlightColor: ハイライト時の色
    ///   - target: タップ時のアクションを飛ばす相手（基本はViewを配置した画面）
    ///   - action: タップ時のアクション
    convenience init(
        contentView: UIView,
        borderColor: UIColor = .lightGray,
        borderWidth: CGFloat = 1.0,
        highlightColor: UIColor = .lightGray,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        self.init()
        
        // ボタンの中身のViewを設定
        self.contentView = contentView
        self.addSubview(contentView)
        
        // 「＞」の画像を設定
        imageView.image = UIImage(named: "arrow-icon")
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        // ボーダーの色を設定
        self.borderColor = borderColor
        
        // ボーダーの太さを設定
        self.borderWidth = borderWidth
        
        // アクションの設定
        if let _action: Selector = action {
            let tapGesture = UITapGestureRecognizer(target: target, action: _action)
            self.addGestureRecognizer(tapGesture)
        }
        
        // ハイライト用のviewを設定
        highlightView.backgroundColor = highlightColor
        highlightView.alpha = 0.0
        self.addSubview(highlightView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - AutoLayout
    /// AutoLayoutを設定
    ///   - contentViewPaddingRight: contentViewの右側の余白
    ///   - imageViewPaddingRight: imageViewの右側の余白
    func setAutoLayout(contentViewPaddingRight: CGFloat = 0.0, imageViewPaddingRight: CGFloat = 0.0) {
        // ボタンの中身のViewの設定
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        contentView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView?.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView?.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -contentViewPaddingRight).isActive = true
        // 画像の設定
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -imageViewPaddingRight).isActive = true
        if let image = imageView.image {
            imageView.widthAnchor.constraint(equalToConstant: image.size.width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: image.size.height).isActive = true
        }
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        // 上下のボーダーの設定
        self.drawTopBorder(color: borderColor!, borderWidth: borderWidth!)
        self.drawBottomBorder(color: borderColor!, borderWidth: borderWidth!)
        // ハイライト用のViewの設定
        highlightView.translatesAutoresizingMaskIntoConstraints = false
        highlightView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        highlightView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        highlightView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        highlightView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
}
