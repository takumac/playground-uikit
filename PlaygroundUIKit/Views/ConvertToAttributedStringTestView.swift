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
    let labelBaseView: UIView = UIView()
    let label: CustomTagLabel = CustomTagLabel()
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
        
        titleLabel1.text = "UITextView"
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
        
        titleLabel2.text = "UILabel"
        titleLabel2.font = UIFont(name: "HiraKakuProN-W6", size: 24)
        titleLabel2.sizeToFit()
        scrollView.addSubview(titleLabel2)
        
        labelBaseView.backgroundColor = C03_COLOR
        labelBaseView.layer.borderColor = UIColor.lightGray.cgColor
        labelBaseView.layer.borderWidth = 1
        
        label.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        label.backgroundColor = C03_COLOR
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.sizeToFit()
        label.actionHandlers = [
            { print("1つ目タップ") },
            { print("2つ目タップ") }
        ]
        labelBaseView.addSubview(label)
        
        scrollView.addSubview(labelBaseView)
        
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
        
        labelBaseView.translatesAutoresizingMaskIntoConstraints = false
        labelBaseView.topAnchor.constraint(equalTo: titleLabel2.bottomAnchor, constant: 25).isActive = true
        labelBaseView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100).isActive = true
        labelBaseView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8).isActive = true
        labelBaseView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: labelBaseView.topAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: labelBaseView.bottomAnchor, constant: -10).isActive = true
        label.leadingAnchor.constraint(equalTo: labelBaseView.leadingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: labelBaseView.trailingAnchor, constant: -5).isActive = true
    }
    
    
    // MARK: - Action
    @objc func scrollViewTapAction(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @objc func sampleButtonTapAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            textView.text = "こんにちは、今日は<b>天気</b>がいい。"
        case 2:
            textView.text = "<strong><u>取引利用料改定後に同意した取引</u></strong>は、4.4%(税込)の利用料率が適用されます。詳しくはコチラ"
        case 3:
            textView.text = "タップアクション<color=\"#0000FF\"><action>ここをタップ1</action></color>aaa<bold><action><color=\"#FF0000\">ここをタップ2</color></action></bold>タップアクション"
        case 4:
            textView.text =
            "<bold><underline><color=\"#FF0000\">あ</color>い<color=\"#00FF00\">う</color>え<color=\"#0000FF\">お</color></underline></bold>\n" +
            "ほげ１<underline><color=\"#FF0000\">abcdefg</color>ほげ２<color=\"#00FF00\">カキクケコ</color><color=\"#0000FF\">xyz</color><bold>ほげ３</bold></underline>ほげ4\n" +
            "リスト\n<list=\"＊\"><line><bold><color=\"#FF0000\">hoge</color></bold></line><line>fuga</line><line>foo</line></list>\n" +
            "オーダーリスト\n<orderlist><orderline><color=\"#FF0000\">hoge</color></orderline><orderline><color=\"#00FF00\"><bold>fuga</bold></color></orderline><orderline><color=\"#0000FF\">foo</color></orderline><orderline>foo</orderline><orderline>foo</orderline></orderlist>\n" +
            "\nタップアクション\n\n\n<color=\"#0000FF\"><action>ここをタップ1</action></color>\n\n\n<bold><action><color=\"#FF0000\">ここをタップ2</color></action></bold>\n" +
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
            label.attributedText = str.htmlToAttributedString(
                withFont: label.font,
                withColor: label.textColor,
                lineHeightMultiple: 1.3
            )
        case 2:
            label.attributedText = str.customTagToAttributedString(
                from: str,
                actions: [
                    { print("1つ目タップ") },
                    { print("2つ目タップ") }
                ]
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


// タップアクション用のカスタム UILabel
class CustomTagLabel: UILabel {
    var actionHandlers: [() -> Void] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isUserInteractionEnabled = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        guard let attributedText = self.attributedText else { return }
        
        let location = touch.location(in: self)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: attributedText)
        let labelSize = self.bounds.size
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = self.lineBreakMode
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.size = labelSize

        // タップ位置の補正
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (labelSize.width - textBoundingBox.size.width) * 0.5,
            y: (labelSize.height - textBoundingBox.size.height) * 0.5
        )
        let locationOfTouchInTextContainer = CGPoint(
            x: location.x - textContainerOffset.x,
            y: location.y - textContainerOffset.y
        )
        let indexOfCharacter = layoutManager.characterIndex(
            for: locationOfTouchInTextContainer,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )
        
        // タップされた位置がカスタムアクションの範囲内かを確認
        for (i, range) in attributedText.getCustomActionRanges().enumerated() {
            if NSLocationInRange(indexOfCharacter, range) {
                actionHandlers[i]()
                break
            }
        }
    }
}
