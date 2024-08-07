//
//  PickerTextFieldTestView.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/08/07.
//

import Foundation
import UIKit

class PickerTextFieldTestView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// ピッカーの入力値となる配列
    var pickerArray: [String] = [
        "hoge",
        "foo",
        "bar",
        "hogehoge",
        "foofoo",
        "barbar"
    ]
    
    /// 入力欄
    var input: UIView = UIView()
    /// 入力用TextField
    var inputTextField: UITextField = UITextField()
    /// 入力用TextFieldの横に配置する下矢印マーク
    var underArrowImageView: UIImageView = UIImageView()
    /// 入力用のPicker
    var picker: UIPickerView = UIPickerView()
    /// 入力用のPickerに配置するツールバー
    var toolBar: UIToolbar = UIToolbar()
    
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
        // 入力欄
        input.layer.borderColor = UIColor.lightGray.cgColor
        input.layer.borderWidth = 1.0
        input.layer.cornerRadius = 5

        // 入力用TextField
        inputTextField.font = UIFont(name: "HiraKakuProN-W6", size: 16)
        inputTextField.placeholder = "選択してください"

        // 入力用TextFieldの横に配置する下矢印マーク
        underArrowImageView.image = UIImage(named: "arrow-down-gray")
        underArrowImageView.contentMode = .scaleAspectFit

        // 入力用のPicker
        picker.frame.size.width = SizeConstant.shared.SCREEN_WIDTH
        picker.frame.size.height = 220
        picker.delegate = self
        picker.dataSource = self
        inputTextField.inputView = picker

        // 入力用のPickerに配置するToolBar
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 50))
        toolBar.sizeToFit()
        // ToolBarに完了ボタンを配置
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(self.tapPickerToolBarButton(sender:)))
        let flexibleItem1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexibleItem1, doneButton]
        inputTextField.inputAccessoryView = toolBar

        input.addSubview(inputTextField)
        input.addSubview(underArrowImageView)
        
        self.addSubview(input)
        
        
        // AutoLayout
        // 入力欄
        input.translatesAutoresizingMaskIntoConstraints = false
        input.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        input.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        input.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100).isActive = true

        // 入力用TextField
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.topAnchor.constraint(equalTo: input.topAnchor, constant: 12).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: input.bottomAnchor, constant: -12).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: input.leadingAnchor, constant: 12).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: input.trailingAnchor, constant: -12).isActive = true

        // 入力用TextFieldの横に配置する下矢印マーク
        underArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        underArrowImageView.topAnchor.constraint(equalTo: inputTextField.topAnchor).isActive = true
        underArrowImageView.bottomAnchor.constraint(equalTo: inputTextField.bottomAnchor).isActive = true
        underArrowImageView.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor).isActive = true
    }
    
    
    // MARK: - DataSource(UIPickerViewDataSource)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    
    // MARK: - Delegate(UIPickerViewDlegate)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.inputTextField.text = pickerArray[row]
    }
    
    
    // MARK: - Action
    @objc func tapPickerToolBarButton(sender: UIBarButtonItem) {
        inputTextField.resignFirstResponder()
    }
    
}
