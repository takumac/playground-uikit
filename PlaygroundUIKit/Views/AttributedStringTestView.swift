//
//  AttributedStringTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2025/07/03.
//

import UIKit

class AttributedStringTestView: UIView {
    
    // MARK: - Member
    let scrollView: UIScrollView = UIScrollView()
    let contentView: UIView = UIView()
    
    let label1BaseView: UIView = UIView()
    let label1 = UILabel()
    
    let label2BaseView: UIView = UIView()
    let label2 = UILabel()
    
    let label3BaseView: UIView = UIView()
    let label3StackView: UIStackView = UIStackView()
    let label3_1 = UILabel()
    let label3_2 = UILabel()
    let label3_3 = UILabel()
    
    let label4BaseView: UIView = UIView()
    let textView4: UITextView = UITextView()
    
    
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
        
        // MARK: Label1
        label1BaseView.backgroundColor = .lightGray
        
        let label1Str = "2次元コードを表示しますか？\n（2次元コードはボタンの下に表示されます）\n\n表示から30日以内に発送手続の完了が必要です。"
        let label1AttrStr: NSMutableAttributedString = NSMutableAttributedString(string: label1Str)
        label1.font = UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 16)
        label1.text = label1Str
        label1.numberOfLines = 0
        label1.lineBreakMode = .byCharWrapping
        
        // 行間設定、文字寄せ1
        let paragraph1 = NSMutableParagraphStyle()
        paragraph1.alignment = .center
        paragraph1.lineHeightMultiple = 1.3
        label1AttrStr.addAttribute(
            .paragraphStyle,
            value: paragraph1,
            range: NSMakeRange(0, 14)
        )
        label1AttrStr.addAttribute(
            .paragraphStyle,
            value: paragraph1,
            range: NSMakeRange(15, 21)
        )
        // 行間設定、文字寄せ2
        let paragraph2 = NSMutableParagraphStyle()
        paragraph2.alignment = .left
        paragraph2.lineHeightMultiple = 1.3
        label1AttrStr.addAttribute(
            .paragraphStyle,
            value: paragraph2,
            range: NSMakeRange(38, 23)
        )
        
        // 文字設定1
        label1AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            range: NSMakeRange(0, 14)
        )
        // 文字設定2
        label1AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W3, size: 16) as Any,
            range: NSMakeRange(15, 21)
        )
        // 文字設定3
        label1AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.black
        ], range: NSMakeRange(38, 4))
        // 文字設定4
        // OKパターン
//        if #available(iOS 16, *) {
//            // iOS16以降の場合の場合
//            label1AttrStr.addAttributes([
//                .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
//                .foregroundColor: UIColor.red,
//                .underlineStyle: NSUnderlineStyle.single.rawValue,
//                .underlineColor: UIColor.red,
//            ], range: NSMakeRange(42, 5))
//        } else {
//            // iOS16未満の場合
//            label1AttrStr.addAttributes([
//                .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
//                .foregroundColor: UIColor.red,
//                .underlineStyle: NSUnderlineStyle.single.rawValue,
//                .underlineColor: UIColor.black
//            ], range: NSMakeRange(42, 5))
//        }
        // NGパターン
        label1AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.red,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.red,
        ], range: NSMakeRange(42, 5))
        // 文字設定5
        label1AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.black
        ], range: NSMakeRange(47, 8))
        // 文字設定6
        label1AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            range: NSMakeRange(55, 6)
        )
        label1.attributedText = label1AttrStr
        label1BaseView.addSubview(label1)
        
        // Label1 AutoLayout
        label1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: label1BaseView.topAnchor, constant: 8),
            label1.bottomAnchor.constraint(equalTo: label1BaseView.bottomAnchor, constant: -8),
            label1.leadingAnchor.constraint(equalTo: label1BaseView.leadingAnchor, constant: 20),
            label1.trailingAnchor.constraint(equalTo: label1BaseView.trailingAnchor, constant: -20),
        ])
        
        
        // MARK: Label2
        label2BaseView.backgroundColor = .lightGray
        
        let label2Str = "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let label2AttrStr: NSMutableAttributedString = NSMutableAttributedString(string: label2Str)
        label2.font = UIFont(name: HIRAGINO_KAKU_GOTHIC_W3, size: 16)
        label2.text = label1Str
        label2.numberOfLines = 0
        label2.lineBreakMode = .byCharWrapping
        label2.attributedText = label2AttrStr
        label2BaseView.addSubview(label2)
        
        // Label2 AutoLayout
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: label2BaseView.topAnchor, constant: 8),
            label2.bottomAnchor.constraint(equalTo: label2BaseView.bottomAnchor, constant: -8),
            label2.leadingAnchor.constraint(equalTo: label2BaseView.leadingAnchor, constant: 20),
            label2.trailingAnchor.constraint(equalTo: label2BaseView.trailingAnchor, constant: -20),
        ])
        
        
        // MARK: Label3
        label3BaseView.backgroundColor = .lightGray
        
        label3StackView.axis = .horizontal
        label3StackView.alignment = .firstBaseline
        label3StackView.spacing = 0
        label3StackView.distribution = .fill
        
        let label3_1_Str = "表示から"
        let label3_2_Str = "30日以内"
        let label3_3_Str = "に発送手続の完了が必要です"
        
        let label3_1_AttrStr: NSMutableAttributedString = NSMutableAttributedString(string: label3_1_Str)
        label3_1_AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.black
        ], range: NSMakeRange(0, label3_1_AttrStr.length))
        
        let label3_2_AttrStr: NSMutableAttributedString = NSMutableAttributedString(string: label3_2_Str)
        label3_2_AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.red,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.red
        ], range: NSMakeRange(0, label3_2_AttrStr.length))
        
        let label3_3_AttrStr: NSMutableAttributedString = NSMutableAttributedString(string: label3_3_Str)
        label3_3_AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            range: NSMakeRange(0, label3_3_AttrStr.length)
        )
        label3_3_AttrStr.addAttributes([
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.black
        ], range: NSMakeRange(0, 8))
        
        label3_1.font = UIFont(name: HIRAGINO_KAKU_GOTHIC_W3, size: 16)
        label3_1.text = label3_1_Str
        label3_1.numberOfLines = 0
        label3_1.lineBreakMode = .byCharWrapping
        label3_1.attributedText = label3_1_AttrStr
        
        label3_2.font = UIFont(name: HIRAGINO_KAKU_GOTHIC_W3, size: 16)
        label3_2.text = label3_2_Str
        label3_2.numberOfLines = 0
        label3_2.lineBreakMode = .byCharWrapping
        label3_2.attributedText = label3_2_AttrStr
        
        label3_3.font = UIFont(name: HIRAGINO_KAKU_GOTHIC_W3, size: 16)
        label3_3.text = label3_3_Str
        label3_3.numberOfLines = 0
        label3_3.lineBreakMode = .byCharWrapping
        label3_3.attributedText = label3_3_AttrStr
        
        label3StackView.addArrangedSubview(label3_1)
        label3StackView.addArrangedSubview(label3_2)
        label3StackView.addArrangedSubview(label3_3)
        label3BaseView.addSubview(label3StackView)
        
        // Label3 AutoLayout
        label3StackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label3StackView.topAnchor.constraint(equalTo: label3BaseView.topAnchor, constant: 8),
            label3StackView.bottomAnchor.constraint(equalTo: label3BaseView.bottomAnchor, constant: -8),
            label3StackView.leadingAnchor.constraint(equalTo: label3BaseView.leadingAnchor, constant: 20),
            label3StackView.trailingAnchor.constraint(equalTo: label3BaseView.trailingAnchor, constant: -20),
        ])
        
        
        // MARK: Label4
        // Label4での実験が成功例
        // →→iOS16未満はUILabelでなくUITextViewを使えば良い。
        label4BaseView.backgroundColor = .lightGray
        
        let label4Str = "2次元コードを表示しますか？\n（2次元コードはボタンの下に表示されます）\n\n表示から30日以内に発送手続の完了が必要です。"
        let label4AttrStr: NSMutableAttributedString = NSMutableAttributedString(string: label4Str)
        
        textView4.isEditable = false
        textView4.isScrollEnabled = false
        textView4.backgroundColor = .clear
        textView4.textContainerInset = .zero
        textView4.textContainer.lineFragmentPadding = 0
        
        // 行間設定、文字寄せ1
        let paragraph4_1 = NSMutableParagraphStyle()
        paragraph4_1.alignment = .center
        paragraph4_1.lineHeightMultiple = 1.3
        label4AttrStr.addAttribute(
            .paragraphStyle,
            value: paragraph4_1,
            range: NSMakeRange(0, 14)
        )
        label4AttrStr.addAttribute(
            .paragraphStyle,
            value: paragraph4_1,
            range: NSMakeRange(15, 21)
        )
        // 行間設定、文字寄せ2
        let paragraph4_2 = NSMutableParagraphStyle()
        paragraph4_2.alignment = .left
        paragraph4_2.lineHeightMultiple = 1.3
        label4AttrStr.addAttribute(
            .paragraphStyle,
            value: paragraph4_2,
            range: NSMakeRange(38, 23)
        )
        
        // 文字設定1
        label4AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            range: NSMakeRange(0, 14)
        )
        // 文字設定2
        label4AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W3, size: 16) as Any,
            range: NSMakeRange(15, 21)
        )
        // 文字設定3
        label4AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.black
        ], range: NSMakeRange(38, 4))
        // 文字設定4
        label4AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.red,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.red,
        ], range: NSMakeRange(42, 5))
        // 文字設定5
        label4AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.black
        ], range: NSMakeRange(47, 8))
        // 文字設定6
        label4AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            range: NSMakeRange(55, 6)
        )
        textView4.attributedText = label4AttrStr
        label4BaseView.addSubview(textView4)
        
        // Label4 AutoLayout
        textView4.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView4.topAnchor.constraint(equalTo: label4BaseView.topAnchor, constant: 8),
            textView4.bottomAnchor.constraint(equalTo: label4BaseView.bottomAnchor, constant: -8),
            textView4.leadingAnchor.constraint(equalTo: label4BaseView.leadingAnchor, constant: 20),
            textView4.trailingAnchor.constraint(equalTo: label4BaseView.trailingAnchor, constant: -20),
        ])
        
        
        // 各ラベルを追加
        contentView.addSubview(label2BaseView)
        contentView.addSubview(label1BaseView)
        contentView.addSubview(label3BaseView)
        contentView.addSubview(label4BaseView)
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        
        // AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        label1BaseView.translatesAutoresizingMaskIntoConstraints = false
        label2BaseView.translatesAutoresizingMaskIntoConstraints = false
        label3BaseView.translatesAutoresizingMaskIntoConstraints = false
        label4BaseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            label1BaseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            label1BaseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label1BaseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label2BaseView.topAnchor.constraint(equalTo: label1BaseView.bottomAnchor, constant: 40),
            label2BaseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label2BaseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label3BaseView.topAnchor.constraint(equalTo: label2BaseView.bottomAnchor, constant: 40),
            label3BaseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label3BaseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label4BaseView.topAnchor.constraint(equalTo: label3BaseView.bottomAnchor, constant: 40),
            label4BaseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -500),
            label4BaseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label4BaseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
}
