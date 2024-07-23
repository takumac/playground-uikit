//
//  RootView.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/06/21.
//

import Foundation
import UIKit

protocol RootViewDelegate {
    func phpickerButtonTapAction()
    func listButtonButtonTapAction()
    func accordionButtonButtonTapAction()
    func pickerTextFieldButtonTapAction()
    func tableViewButtonTapAction()
    func radioButtonTapAction()
    func globalFrameButtonTapAction()
}

class RootView: UIView {
    
    /// Delegate
    var rootViewDelegate: RootViewDelegate?
    
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
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLoad
    func viewLoad() {
        contentView.axis = .vertical
        contentView.alignment = .fill
        contentView.distribution = .equalSpacing
        contentView.spacing = 50
        
        phpickerButton.setTitle("PHPicker", for: .normal)
        phpickerButton.setTitleColor(.blue, for: .normal)
        phpickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        phpickerButton.sizeToFit()
        phpickerButton.addTarget(self, action: #selector(phpickerButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(phpickerButton)
        
        listButtonButton.setTitle("listButton", for: .normal)
        listButtonButton.setTitleColor(.blue, for: .normal)
        listButtonButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        listButtonButton.sizeToFit()
        listButtonButton.addTarget(self, action: #selector(listButtonButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(listButtonButton)
        
        accordionButtonButton.setTitle("accordionButtonButton", for: .normal)
        accordionButtonButton.setTitleColor(.blue, for: .normal)
        accordionButtonButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        accordionButtonButton.sizeToFit()
        accordionButtonButton.addTarget(self, action: #selector(accordionButtonButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(accordionButtonButton)
        
        pickerTextFieldButton.setTitle("pickerTextFieldButton", for: .normal)
        pickerTextFieldButton.setTitleColor(.blue, for: .normal)
        pickerTextFieldButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        pickerTextFieldButton.sizeToFit()
        pickerTextFieldButton.addTarget(self, action: #selector(pickerTextFieldButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(pickerTextFieldButton)
        
        tableViewButton.setTitle("tableViewButton", for: .normal)
        tableViewButton.setTitleColor(.blue, for: .normal)
        tableViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        tableViewButton.sizeToFit()
        tableViewButton.addTarget(self, action: #selector(tableViewButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(tableViewButton)
        
        radioButton.setTitle("radioButtonButton", for: .normal)
        radioButton.setTitleColor(.blue, for: .normal)
        radioButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        radioButton.sizeToFit()
        radioButton.addTarget(self, action: #selector(radioButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(radioButton)
        
        globalFrameButton.setTitle("globalFrameButton", for: .normal)
        globalFrameButton.setTitleColor(.blue, for: .normal)
        globalFrameButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        globalFrameButton.sizeToFit()
        globalFrameButton.addTarget(self, action: #selector(globalFrameButtonTapAction(_:)), for: .touchUpInside)
        contentView.addArrangedSubview(globalFrameButton)
        
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        
        // AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        
        phpickerButton.translatesAutoresizingMaskIntoConstraints = false
        phpickerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        listButtonButton.translatesAutoresizingMaskIntoConstraints = false
        listButtonButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        accordionButtonButton.translatesAutoresizingMaskIntoConstraints = false
        accordionButtonButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        pickerTextFieldButton.translatesAutoresizingMaskIntoConstraints = false
        pickerTextFieldButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        tableViewButton.translatesAutoresizingMaskIntoConstraints = false
        tableViewButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        globalFrameButton.translatesAutoresizingMaskIntoConstraints = false
        globalFrameButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
    
    // MARK: - Action
    @objc func phpickerButtonTapAction(_ sender: UIButton) {
        rootViewDelegate?.phpickerButtonTapAction()
    }
    
    @objc func listButtonButtonTapAction(_ sender: UIButton) {
        rootViewDelegate?.listButtonButtonTapAction()
    }
    
    @objc func accordionButtonButtonTapAction(_ sender: UIButton) {
        rootViewDelegate?.accordionButtonButtonTapAction()
    }
    
    @objc func pickerTextFieldButtonTapAction(_ sender: UIButton) {
        rootViewDelegate?.pickerTextFieldButtonTapAction()
    }
    
    @objc func tableViewButtonTapAction(_ sender: UIButton) {
        rootViewDelegate?.tableViewButtonTapAction()
    }
    
    @objc func radioButtonTapAction(_ sender: UIButton) {
        rootViewDelegate?.radioButtonTapAction()
    }
    
    @objc func globalFrameButtonTapAction(_ sender: UIButton) {
        rootViewDelegate?.globalFrameButtonTapAction()
    }
    
    
}
