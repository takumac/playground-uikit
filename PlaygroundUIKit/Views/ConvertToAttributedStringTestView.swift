//
//  ConvertToAttributedStringTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/08/07.
//

import UIKit

class ConvertToAttributedStringTestView: UIView {
    
    // MARK: - Member
    let scrollView: UIScrollView = UIScrollView()
    let textView: UITextView = UITextView()
    let customTagTV: CustomTagTextView = CustomTagTextView()
    let titleLabel1: UILabel = UILabel()
    let titleLabel2: UILabel = UILabel()
    let titleLabel3: UILabel = UILabel()
    let titleLabel4: UILabel = UILabel()
    let sampleButtonSV: UIStackView = UIStackView()
    let sampleButton1: UIButton = UIButton()
    let sampleButton2: UIButton = UIButton()
    let sampleButton3: UIButton = UIButton()
    let sampleButton4: UIButton = UIButton()
    let convertButtonSV: UIStackView = UIStackView()
    let convertButton1: UIButton = UIButton()
    let convertButton2: UIButton = UIButton()
    
    
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
        
        let scrollViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapAction(_:)))
        scrollViewTapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(scrollViewTapGesture)
        
        titleLabel1.text = "Before Convert Text"
        titleLabel1.font = UIFont(name: "HiraKakuProN-W6", size: 24)
        titleLabel1.sizeToFit()
        scrollView.addSubview(titleLabel1)
        
        textView.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        textView.backgroundColor = C03_COLOR
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        scrollView.addSubview(textView)
        
        titleLabel3.text = "Sample Text"
        titleLabel3.font = UIFont(name: "HiraKakuProN-W6", size: 24)
        titleLabel3.sizeToFit()
        scrollView.addSubview(titleLabel3)
        
        sampleButtonSV.axis = .horizontal
        sampleButtonSV.alignment = .center
        sampleButtonSV.distribution = .equalSpacing
        sampleButtonSV.isLayoutMarginsRelativeArrangement = true
        sampleButtonSV.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        sampleButton1.setTitle("Text1", for: .normal)
        sampleButton1.setTitleColor(C02_COLOR, for: .normal)
        sampleButton1.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        sampleButton1.tag = 1
        sampleButton1.sizeToFit()
        sampleButton1.addTarget(self, action: #selector(sampleButtonTapAction(_:)), for: .touchUpInside)
        sampleButtonSV.addArrangedSubview(sampleButton1)
        
        sampleButton2.setTitle("Text2", for: .normal)
        sampleButton2.setTitleColor(C02_COLOR, for: .normal)
        sampleButton2.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        sampleButton2.tag = 2
        sampleButton2.sizeToFit()
        sampleButton2.addTarget(self, action: #selector(sampleButtonTapAction(_:)), for: .touchUpInside)
        sampleButtonSV.addArrangedSubview(sampleButton2)
        
        sampleButton3.setTitle("Text3", for: .normal)
        sampleButton3.setTitleColor(C02_COLOR, for: .normal)
        sampleButton3.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        sampleButton3.tag = 3
        sampleButton3.sizeToFit()
        sampleButton3.addTarget(self, action: #selector(sampleButtonTapAction(_:)), for: .touchUpInside)
        sampleButtonSV.addArrangedSubview(sampleButton3)
        
        sampleButton4.setTitle("Text4", for: .normal)
        sampleButton4.setTitleColor(C02_COLOR, for: .normal)
        sampleButton4.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        sampleButton4.tag = 4
        sampleButton4.sizeToFit()
        sampleButton4.addTarget(self, action: #selector(sampleButtonTapAction(_:)), for: .touchUpInside)
        sampleButtonSV.addArrangedSubview(sampleButton4)
        
        scrollView.addSubview(sampleButtonSV)
        
        titleLabel4.text = "Convert Button"
        titleLabel4.font = UIFont(name: "HiraKakuProN-W6", size: 24)
        titleLabel4.sizeToFit()
        scrollView.addSubview(titleLabel4)
        
        convertButtonSV.axis = .horizontal
        convertButtonSV.alignment = .center
        convertButtonSV.distribution = .equalSpacing
        convertButtonSV.isLayoutMarginsRelativeArrangement = true
        convertButtonSV.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        convertButton1.setTitle("HTML", for: .normal)
        convertButton1.setTitleColor(C02_COLOR, for: .normal)
        convertButton1.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        convertButton1.sizeToFit()
        convertButton1.addTarget(self, action: #selector(convertButtonTapAction(_:)), for: .touchUpInside)
        convertButton1.tag = 1
        convertButtonSV.addArrangedSubview(convertButton1)
        
        convertButton2.setTitle("CustomTag", for: .normal)
        convertButton2.setTitleColor(C02_COLOR, for: .normal)
        convertButton2.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        convertButton2.sizeToFit()
        convertButton2.addTarget(self, action: #selector(convertButtonTapAction(_:)), for: .touchUpInside)
        convertButton2.tag = 2
        convertButtonSV.addArrangedSubview(convertButton2)
        
        scrollView.addSubview(convertButtonSV)
        
        titleLabel2.text = "After Convert Text"
        titleLabel2.font = UIFont(name: "HiraKakuProN-W6", size: 24)
        titleLabel2.sizeToFit()
        scrollView.addSubview(titleLabel2)
        
        customTagTV.backgroundColor = C03_COLOR
        customTagTV.sizeToFit()
        customTagTV.actionHandlers = [
            { print("1つ目タップ") },
            { print("2つ目タップ") },
            { print("3つ目タップ") }
        ]
        scrollView.addSubview(customTagTV)
        
        self.addSubview(scrollView)
        
        // AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        titleLabel1.translatesAutoresizingMaskIntoConstraints = false
        titleLabel1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        titleLabel1.widthAnchor.constraint(equalToConstant: titleLabel1.frame.width).isActive = true
        titleLabel1.heightAnchor.constraint(equalToConstant: titleLabel1.frame.height).isActive = true
        titleLabel1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor, constant: 25).isActive = true
        textView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8).isActive = true
        textView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.3).isActive = true
        textView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        titleLabel3.translatesAutoresizingMaskIntoConstraints = false
        titleLabel3.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 50).isActive = true
        titleLabel3.widthAnchor.constraint(equalToConstant: titleLabel3.frame.width).isActive = true
        titleLabel3.heightAnchor.constraint(equalToConstant: titleLabel3.frame.height).isActive = true
        titleLabel3.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        sampleButtonSV.translatesAutoresizingMaskIntoConstraints = false
        sampleButtonSV.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor, constant: 25).isActive = true
        sampleButtonSV.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        sampleButtonSV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        titleLabel4.translatesAutoresizingMaskIntoConstraints = false
        titleLabel4.topAnchor.constraint(equalTo: sampleButtonSV.bottomAnchor, constant: 50).isActive = true
        titleLabel4.widthAnchor.constraint(equalToConstant: titleLabel4.frame.width).isActive = true
        titleLabel4.heightAnchor.constraint(equalToConstant: titleLabel4.frame.height).isActive = true
        titleLabel4.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        convertButtonSV.translatesAutoresizingMaskIntoConstraints = false
        convertButtonSV.topAnchor.constraint(equalTo: titleLabel4.bottomAnchor, constant: 25).isActive = true
        convertButtonSV.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        convertButtonSV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        titleLabel2.topAnchor.constraint(equalTo: convertButtonSV.bottomAnchor, constant: 50).isActive = true
        titleLabel2.widthAnchor.constraint(equalToConstant: titleLabel2.frame.width).isActive = true
        titleLabel2.heightAnchor.constraint(equalToConstant: titleLabel2.frame.height).isActive = true
        titleLabel2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        customTagTV.translatesAutoresizingMaskIntoConstraints = false
        customTagTV.topAnchor.constraint(equalTo: titleLabel2.bottomAnchor, constant: 25).isActive = true
        customTagTV.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100).isActive = true
        customTagTV.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8).isActive = true
        customTagTV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
    
    // MARK: - Action
    @objc func scrollViewTapAction(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @objc func sampleButtonTapAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            textView.text = "<center><bold>「取引内容」と「確認事項」に同意の上、\nお取引の手続きを進めますか？\n\n＜確認事項＞\n<underline>約束メモと実際の取引が異なる</underline></bold>と当社が判断した場合、<bold><color=\"#FF0000\">取引キャンセル</color>になることがあります。</bold></center>"
        case 2:
            textView.text = "<strong><u>取引利用料改定後に同意した取引</u></strong>は、4.4%(税込)の利用料率が適用されます。詳しくはコチラ"
        case 3:
            textView.text = "<lineheightmultiple=\"1.5\">行の高さ\n行の高さ\n行の高さ<fontsize=\"28\">行の高さ</fontsize>\n行の高さ\n行の高さ\nABCDefgh\nabcd</lineheightmultiple>"
        case 4:
            textView.text =
            "<bold><underline><color=\"#FF0000\">あ</color>い<color=\"#00FF00\">う</color>え<color=\"#0000FF\">お</color></underline></bold>\n\n" +
            "ほげ１<underline><color=\"#FF0000\">abcdefg</color>ほげ２<color=\"#00FF00\">カキクケコ</color><color=\"#0000FF\">xyz</color><bold>ほげ３</bold></underline>ほげ4\n\n" +
            "リスト<list=\"＊\"><line><bold><color=\"#FF0000\">hoge</color></bold></line><line>fuga</line><line>foo</line></list>\n" +
            "<center>オーダーリスト<orderlist><orderline><color=\"#FF0000\">hoge</color></orderline><orderline><color=\"#00FF00\"><bold>fuga</bold></color></orderline><orderline><color=\"#0000FF\">foo</color></orderline><orderline>foo</orderline><orderline>foo</orderline></orderlist>\n</center>" +
            "タップアクション\n<linespace=\"30\"><color=\"#0000FF\"><action>ここをタップ1</action></color>\n<bold><action><color=\"#FF0000\"><underline>ここをタップ2</underline></color></action></bold>\n</linespace>" +
            "<linespace=\"60\">フォントサイズ\n</linespace>\n<bold><fontsize=\"10\">フォントサイズ10</fontsize></bold>\n\n<color=\"#FF0000\"><fontsize=\"20\">フォントサイズ20</fontsize></color>\n\n<bold><fontsize=\"30\">フォント<color=\"#0000FF\">サイズ</color>30</fontsize></bold>\n\n" +
            "終わり"
        default:
            return
        }
    }
    
    @objc func convertButtonTapAction(_ sender: UIButton) {
        self.endEditing(true)
        
        let str = textView.text ?? ""
        
        switch sender.tag {
        case 1:
            customTagTV.attributedText = str.htmlToAttributedString(
                withFont: customTagTV.font,
                withColor: customTagTV.textColor,
                lineHeightMultiple: 1.3
            )
        case 2:
            var actionCount = 0
            customTagTV.attributedText = str.customTagToAttributedString(
                withFont: UIFont(name: "HiraKakuProN-W3", size: 14),
                actionCount: &actionCount
            )
        default:
            return
        }
    }
    
    
    // MARK: - TouchEvent
    /// 画面をタップ時に,キーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}


// カスタムタグによる修飾を行ったテキストを表示するためのUITextView
class CustomTagTextView: UITextView, UITextViewDelegate, UITextDragDelegate {
    // MARK: - Member
    /// <action>タグで囲まれたリンクをタップした時のアクションを保持する配列
    var actionHandlers: [() -> Void] = []
    /// TextView自体のタップアクションの有効、無効フラグ
    var isViewTapEnable: Bool = false
    /// TextView自体のタップアクション
    var viewTapAction: (() -> Void)? = nil
    
    
    // MARK: - Init
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    // MARK: - Override
    // <action>タグのタップは有効化するけど、UITextView本来の選択等を無効化するための諸々の設定
    override var isFocused: Bool {
        false
    }
    override var canBecomeFirstResponder: Bool {
        false
    }
    override var canBecomeFocused: Bool {
        false
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
    
    // UITextView自体のタップが有効の場合に、設定されているアクションを実行する
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isViewTapEnable {
            if let action = viewTapAction {
                action()
            }
        }
    }
    
    
    // MARK: - SetUp
    private func setup() {
        // デリゲートを自分自身に設定
        self.delegate = self
        // 編集は不可（表示用とするため）
        self.isEditable = false
        // スクロールは不可（高さを内部のテキストによって可変とするため）
        self.isScrollEnabled = false
        // 選択は可能（<action>タグのタップイベントを検知するため）
        self.isSelectable = true
        // .linkが設定された文字列（AttributedString）はタップ可能とする設定
        self.dataDetectorTypes = [.link]
        // .linkが設定された文字列のデフォルト修飾（青文字＆下線）を無効にする
        self.linkTextAttributes = [:]
        // iOS17以降はリンクタップ時のアクションでUIActionを用いる。
        // 長押し＆ドラッグによりリンクの表示を防ぐためUITextViewの文字のドラッグを防ぐ
        self.textDragDelegate = self
    }
    
    
    // MARK: - Delegate(UITextView)
    // iOS17以降のリンクタップ時の処理
    @available(iOS 17.0, *)
    func textView(
        _ textView: UITextView,
        primaryActionFor textItem: UITextItem,
        defaultAction: UIAction
    ) -> UIAction? {
        guard
            case .link(let url) = textItem.content,
            url.scheme == "action",
            let host = url.host,
            let actionIndex = Int(host),
            (1...self.actionHandlers.count).contains(actionIndex)
        else {
            // 想定していない内容の場合はデフォルトアクション
            return defaultAction
        }
        
        return UIAction(title: "Custom Action") { _ in
            self.actionHandlers[actionIndex - 1]()
        }
    }
    
    // iOS17未満のリンクタップ時の処理
    func textView(
        _ textView: UITextView,
        shouldInteractWith URL: URL,
        in characterRange: NSRange,
        interaction: UITextItemInteraction
    ) -> Bool {
        if #available(iOS 17.0, *) {
            // iOS17以降の端末であれば何もしない
            return false
        }
        
        if URL.scheme == "action",
           let host = URL.host,
           let actionIndex = Int(host),
           (1...actionHandlers.count).contains(actionIndex)
        {
            // 想定している内容の場合はアクション実行
            actionHandlers[actionIndex - 1]()
            return false
        }
        
        return true
    }
    
    
    // MARK: - Delegate(UITextDrag)
    func textDraggableView(
        _ textDraggableView: UIView & UITextDraggable,
        itemsForDrag dragRequest: UITextDragRequest
    ) -> [UIDragItem] {
        // iOS17以降はリンクタップ時のアクションでUIActionを用いる。
        // 長押し＆ドラッグによりリンクの表示を防ぐためUITextViewの文字のドラッグを防ぐ
        return []
    }
}
