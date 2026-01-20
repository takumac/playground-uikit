//
//  Tab1RootView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2026/01/20.
//

import UIKit

protocol Tab1RootViewDelegate: AnyObject {
    func phpickerButtonTapAction()
    func listButtonButtonTapAction()
    func accordionButtonButtonTapAction()
    func pickerTextFieldButtonTapAction()
    func tableViewButtonTapAction()
    func radioButtonTapAction()
    func globalFrameButtonTapAction()
    func convertToAttributedStringButtonTapAction()
    func actionSheetButtonTapAction()
    func attributedStringButtonTapAction()
    func compositionalLayoutButtonTapAction()
    func speechBubbleButtonTapAction()
}


class Tab1RootView: UIView {
    // MARK: - Member
    /// Delegate
    weak var delegate: Tab1RootViewDelegate?
    
    var scrollView: UIScrollView = UIScrollView()
    var contentView: UIStackView = UIStackView()
    
    /// PHPickerの実験画面に飛ぶためのボタン
    let phpickerButton: UIButton = UIButton()
    
    /// ListButtonの実験画面に飛ぶためのボタン
    let listButtonButton: UIButton = UIButton()
    
    /// AccordionButtonの実験画面に飛ぶためのボタン
    let accordionButtonButton: UIButton = UIButton()
    
    /// PickerTextFieldの実験画面に飛ぶためのボタン
    let pickerTextFieldButton: UIButton = UIButton()
    
    /// TableViewの実験画面に飛ぶためのボタン
    let tableViewButton: UIButton = UIButton()
    
    /// RadioButtonの実験画面に飛ぶためのボタン
    let radioButton: UIButton = UIButton()
    
    /// 画面サイズをグローバル変数で定義した場合の実験画面に飛ぶためのボタン
    let globalFrameButton: UIButton = UIButton()
    
    /// 画面サイズをグローバル変数で定義した場合の実験画面に飛ぶためのボタン
    let convertToAttributedStringButton: UIButton = UIButton()
    
    /// アクションシートの実験画面に飛ぶためのボタン
    let actionSheetButton: UIButton = UIButton()
    
    /// AttributedStringの実験画面に飛ぶためのボタン
    let attributedStringButton: UIButton = UIButton()
    
    /// CompositionalLayoutの実験画面に飛ぶためのボタン
    let compositionalLayoutButton: UIButton = UIButton()
    
    /// SpeechBubbleの実験画面に飛ぶためのボタン
    let speechBubbleButton: UIButton = UIButton()
    
    
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
        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.distribution = .equalSpacing
        contentView.spacing = 50
        
        phpickerButton.setTitle("PHPicker", for: .normal)
        phpickerButton.setTitleColor(C02_COLOR, for: .normal)
        phpickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        phpickerButton.addTarget(self, action: #selector(phpickerButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(phpickerButton)
        
        listButtonButton.setTitle("List Button", for: .normal)
        listButtonButton.setTitleColor(C02_COLOR, for: .normal)
        listButtonButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        listButtonButton.addTarget(self, action: #selector(listButtonButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(listButtonButton)
        
        accordionButtonButton.setTitle("Accordion Button", for: .normal)
        accordionButtonButton.setTitleColor(C02_COLOR, for: .normal)
        accordionButtonButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        accordionButtonButton.addTarget(self, action: #selector(accordionButtonButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(accordionButtonButton)
        
        pickerTextFieldButton.setTitle("Picker TextField", for: .normal)
        pickerTextFieldButton.setTitleColor(C02_COLOR, for: .normal)
        pickerTextFieldButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        pickerTextFieldButton.addTarget(self, action: #selector(pickerTextFieldButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(pickerTextFieldButton)
        
        tableViewButton.setTitle("TableView", for: .normal)
        tableViewButton.setTitleColor(C02_COLOR, for: .normal)
        tableViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tableViewButton.addTarget(self, action: #selector(tableViewButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(tableViewButton)
        
        radioButton.setTitle("Radio Button", for: .normal)
        radioButton.setTitleColor(C02_COLOR, for: .normal)
        radioButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        radioButton.addTarget(self, action: #selector(radioButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(radioButton)
        
        globalFrameButton.setTitle("Global Frame", for: .normal)
        globalFrameButton.setTitleColor(C02_COLOR, for: .normal)
        globalFrameButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        globalFrameButton.addTarget(self, action: #selector(globalFrameButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(globalFrameButton)
        
        convertToAttributedStringButton.setTitle("Convert To AttributedString", for: .normal)
        convertToAttributedStringButton.setTitleColor(C02_COLOR, for: .normal)
        convertToAttributedStringButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        convertToAttributedStringButton.addTarget(self, action: #selector(htmlToAttributedStringButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(convertToAttributedStringButton)
        
        actionSheetButton.setTitle("Action Sheet", for: .normal)
        actionSheetButton.setTitleColor(C02_COLOR, for: .normal)
        actionSheetButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        actionSheetButton.addTarget(self, action: #selector(actionSheetButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(actionSheetButton)
        
        attributedStringButton.setTitle("Attributed String", for: .normal)
        attributedStringButton.setTitleColor(C02_COLOR, for: .normal)
        attributedStringButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        attributedStringButton.addTarget(self, action: #selector(attributedStringButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(attributedStringButton)
        
        compositionalLayoutButton.setTitle("Compositional Layout", for: .normal)
        compositionalLayoutButton.setTitleColor(C02_COLOR, for: .normal)
        compositionalLayoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        compositionalLayoutButton.addTarget(self, action: #selector(compositionalLayoutButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(compositionalLayoutButton)
        
        speechBubbleButton.setTitle("Speech Bubble", for: .normal)
        speechBubbleButton.setTitleColor(C02_COLOR, for: .normal)
        speechBubbleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        speechBubbleButton.addTarget(self, action: #selector(speechBubbleButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(speechBubbleButton)
        
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        
        // AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -150),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
        ])
    }
    
    
    // MARK: - Action
    @objc func phpickerButtonTapAction(_ sender: UIButton) {
        delegate?.phpickerButtonTapAction()
    }
    
    @objc func listButtonButtonTapAction(_ sender: UIButton) {
        delegate?.listButtonButtonTapAction()
    }
    
    @objc func accordionButtonButtonTapAction(_ sender: UIButton) {
        delegate?.accordionButtonButtonTapAction()
    }
    
    @objc func pickerTextFieldButtonTapAction(_ sender: UIButton) {
        delegate?.pickerTextFieldButtonTapAction()
    }
    
    @objc func tableViewButtonTapAction(_ sender: UIButton) {
        delegate?.tableViewButtonTapAction()
    }
    
    @objc func radioButtonTapAction(_ sender: UIButton) {
        delegate?.radioButtonTapAction()
    }
    
    @objc func globalFrameButtonTapAction(_ sender: UIButton) {
        delegate?.globalFrameButtonTapAction()
    }
    
    @objc func htmlToAttributedStringButtonTapAction(_ sender: UIButton) {
        delegate?.convertToAttributedStringButtonTapAction()
    }
    
    @objc func actionSheetButtonTapAction(_ sender: UIButton) {
        delegate?.actionSheetButtonTapAction()
    }
    
    @objc func attributedStringButtonTapAction(_ sender: UIButton) {
        delegate?.attributedStringButtonTapAction()
    }
    
    @objc func compositionalLayoutButtonTapAction(_ sender: UIButton) {
        delegate?.compositionalLayoutButtonTapAction()
    }
    
    @objc func speechBubbleButtonTapAction(_ sender: UIButton) {
        delegate?.speechBubbleButtonTapAction()
    }
    
}
