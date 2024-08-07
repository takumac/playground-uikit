//
//  HTMLtoAttributedStringTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/08/07.
//

import UIKit

class HTMLtoAttributedStringTestView: UIView {
    
    // MARK: - Member
    let scrollView: UIScrollView = UIScrollView()
    let textView: UITextView = UITextView()
    let labelBaseView: UIView = UIView()
    let label: UILabel = UILabel()
    let titleLabel1: UILabel = UILabel()
    let titleLabel2: UILabel = UILabel()
    let sampleButtonSV: UIStackView = UIStackView()
    let sampleButton1: UIButton = UIButton()
    let sampleButton2: UIButton = UIButton()
    let convertButton: UIButton = UIButton()
    
    
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
        
        sampleButtonSV.axis = .horizontal
        sampleButtonSV.alignment = .center
        sampleButtonSV.distribution = .equalSpacing
        
        sampleButton1.setTitle("Sample1", for: .normal)
        sampleButton1.setTitleColor(C02_COLOR, for: .normal)
        sampleButton1.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        sampleButton1.tag = 1
        sampleButton1.sizeToFit()
        sampleButton1.addTarget(self, action: #selector(sampleButtonTapAction(_:)), for: .touchUpInside)
        sampleButtonSV.addArrangedSubview(sampleButton1)
        
        sampleButton2.setTitle("Sample2", for: .normal)
        sampleButton2.setTitleColor(C02_COLOR, for: .normal)
        sampleButton2.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        sampleButton2.tag = 2
        sampleButton2.sizeToFit()
        sampleButton2.addTarget(self, action: #selector(sampleButtonTapAction(_:)), for: .touchUpInside)
        sampleButtonSV.addArrangedSubview(sampleButton2)
        
        scrollView.addSubview(sampleButtonSV)
        
        convertButton.setTitle("Convert", for: .normal)
        convertButton.setTitleColor(C02_COLOR, for: .normal)
        convertButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        convertButton.sizeToFit()
        convertButton.addTarget(self, action: #selector(convertButtonTapAction(_:)), for: .touchUpInside)
        scrollView.addSubview(convertButton)
        
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
        
        sampleButtonSV.translatesAutoresizingMaskIntoConstraints = false
        sampleButtonSV.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 50).isActive = true
        sampleButtonSV.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8).isActive = true
        sampleButtonSV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        convertButton.translatesAutoresizingMaskIntoConstraints = false
        convertButton.topAnchor.constraint(equalTo: sampleButtonSV.bottomAnchor, constant: 25).isActive = true
        convertButton.widthAnchor.constraint(equalToConstant: convertButton.frame.width).isActive = true
        convertButton.heightAnchor.constraint(equalToConstant: convertButton.frame.height).isActive = true
        convertButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        titleLabel2.topAnchor.constraint(equalTo: convertButton.bottomAnchor, constant: 50).isActive = true
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
        default:
            return
        }
    }
    
    @objc func convertButtonTapAction(_ sender: UIButton) {
        self.endEditing(true)
        
        let str = textView.text ?? ""
        label.attributedText = str.htmlToAttributedString(withFont: label.font, lineHeightMultiple: 1.3)
    }
    
    
    // MARK: - TouchEvent
    /// 画面をタップ時に,キーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
