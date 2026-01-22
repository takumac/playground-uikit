//
//  RadioButtonTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/03/01.
//

import UIKit

protocol RadioButtonTestViewDelegate: AnyObject {
    func radioButton1TapAction()
}


class RadioButtonTestView: UIView {
    
    // MARK: - Member
    /// Delegate
    weak var delegate: RadioButtonTestViewDelegate?
    
    let scrollView: UIScrollView = UIScrollView()
    let contentView = UIView()
    
    let baseView1: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = C03_COLOR
        uiView.layer.cornerRadius = 8
        uiView.layer.borderColor = UIColor.rgb(r: 230, g: 230, b: 230, alpha: 1).cgColor
        uiView.layer.borderWidth = 2.0
        uiView.tag = 1
        
        return uiView
    }()
    
    let radioButton1_1: RadioButton1 = {
        let radioButton1: RadioButton1 = RadioButton1(diameter: 20)
        
        return radioButton1
    }()
    
    let textLabel1_1: UILabel = {
        let label = UILabel()
        label.text = "hogehogehogehogehogehoge"
        
        return label
    }()
    
    let textLabel1_2: UILabel = {
        let label = UILabel()
        label.text = "fugafugafugafugafugafuga"
        
        return label
    }()
    
    let textLabel1_3: UILabel = {
        let label = UILabel()
        label.text = "foofoofoofoofoofoo"
        
        return label
    }()
    
    let baseView2: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = C03_COLOR
        uiView.layer.cornerRadius = 8
        uiView.layer.borderColor = UIColor.rgb(r: 230, g: 230, b: 230, alpha: 1).cgColor
        uiView.layer.borderWidth = 2.0
        uiView.tag = 2
        
        return uiView
    }()
    
    let radioButton1_2: RadioButton1 = {
        let radioButton1: RadioButton1 = RadioButton1(diameter: 20)
        radioButton1.tag = 1
        
        return radioButton1
    }()
    
    let textLabel2_1: UILabel = {
        let label = UILabel()
        label.text = "hogehogehoge2"
        
        return label
    }()
    
    let textLabel2_2: UILabel = {
        let label = UILabel()
        label.text = "fugafugafuga2"
        
        return label
    }()
    
    let textLabel2_3: UILabel = {
        let label = UILabel()
        label.text = "foofoofoo2"
        
        return label
    }()
    
    
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
        // ViewSetting
        let baseView1tapGesture = UITapGestureRecognizer(target: self, action: #selector(radioButton1BaseViewTapAction(_:)))
        baseView1.addGestureRecognizer(baseView1tapGesture)
        let baseView2tapGesture = UITapGestureRecognizer(target: self, action: #selector(radioButton1BaseViewTapAction(_:)))
        baseView2.addGestureRecognizer(baseView2tapGesture)
        
        // ラジオボタン1
        baseView1.addSubview(radioButton1_1)
        baseView1.addSubview(textLabel1_1)
        baseView1.addSubview(textLabel1_2)
        baseView1.addSubview(textLabel1_3)
        radioButton1_1.translatesAutoresizingMaskIntoConstraints = false
        textLabel1_1.translatesAutoresizingMaskIntoConstraints = false
        textLabel1_2.translatesAutoresizingMaskIntoConstraints = false
        textLabel1_3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            radioButton1_1.topAnchor.constraint(equalTo: baseView1.topAnchor, constant: 20),
            radioButton1_1.leadingAnchor.constraint(equalTo: baseView1.leadingAnchor, constant: 16),
            radioButton1_1.widthAnchor.constraint(equalToConstant: radioButton1_1.frame.width),
            radioButton1_1.heightAnchor.constraint(equalToConstant: radioButton1_1.frame.height),
            textLabel1_1.leadingAnchor.constraint(equalTo: radioButton1_1.trailingAnchor, constant: 32),
            textLabel1_1.centerYAnchor.constraint(equalTo: radioButton1_1.centerYAnchor),
            textLabel1_2.topAnchor.constraint(equalTo: textLabel1_1.bottomAnchor, constant: 20),
            textLabel1_2.leadingAnchor.constraint(equalTo: textLabel1_1.leadingAnchor),
            textLabel1_3.topAnchor.constraint(equalTo: textLabel1_2.bottomAnchor, constant: 20),
            textLabel1_3.bottomAnchor.constraint(equalTo: baseView1.bottomAnchor, constant: -20),
            textLabel1_3.leadingAnchor.constraint(equalTo: textLabel1_1.leadingAnchor),
        ])
        
        // ラジオボタン2
        baseView2.addSubview(radioButton1_2)
        baseView2.addSubview(textLabel2_1)
        baseView2.addSubview(textLabel2_2)
        baseView2.addSubview(textLabel2_3)
        radioButton1_2.translatesAutoresizingMaskIntoConstraints = false
        textLabel2_1.translatesAutoresizingMaskIntoConstraints = false
        textLabel2_2.translatesAutoresizingMaskIntoConstraints = false
        textLabel2_3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            radioButton1_2.topAnchor.constraint(equalTo: baseView2.topAnchor, constant: 20),
            radioButton1_2.leadingAnchor.constraint(equalTo: baseView2.leadingAnchor, constant: 16),
            radioButton1_2.widthAnchor.constraint(equalToConstant: radioButton1_2.frame.width),
            radioButton1_2.heightAnchor.constraint(equalToConstant: radioButton1_2.frame.height),
            textLabel2_1.leadingAnchor.constraint(equalTo: radioButton1_2.trailingAnchor, constant: 32),
            textLabel2_1.centerYAnchor.constraint(equalTo: radioButton1_2.centerYAnchor),
            textLabel2_2.topAnchor.constraint(equalTo: textLabel2_1.bottomAnchor, constant: 20),
            textLabel2_2.leadingAnchor.constraint(equalTo: textLabel2_1.leadingAnchor),
            textLabel2_3.topAnchor.constraint(equalTo: textLabel2_2.bottomAnchor, constant: 20),
            textLabel2_3.bottomAnchor.constraint(equalTo: baseView2.bottomAnchor, constant: -20),
            textLabel2_3.leadingAnchor.constraint(equalTo: textLabel2_1.leadingAnchor)
        ])
        
        // 全体
        contentView.addSubview(baseView1)
        contentView.addSubview(baseView2)
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        
        // AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        baseView1.translatesAutoresizingMaskIntoConstraints = false
        baseView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            baseView1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            baseView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            baseView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            baseView2.topAnchor.constraint(equalTo: baseView1.bottomAnchor, constant: 40),
            baseView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -600),
            baseView2.leadingAnchor.constraint(equalTo: baseView1.leadingAnchor),
            baseView2.trailingAnchor.constraint(equalTo: baseView1.trailingAnchor),
        ])
    }
    
    
    // MARK: - Action
    @objc func radioButton1BaseViewTapAction(_ sender: UITapGestureRecognizer) {
        if let tappedView = sender.view {
            switch tappedView.tag {
            case 1:
                if radioButton1_1.isSelected {
                    baseView1.layer.add(deselectAnimationGroup(), forKey: "deselectAnimationGroup")
                    radioButton1_1.deselect()
                } else {
                    if radioButton1_2.isSelected {
                        baseView2.layer.add(deselectAnimationGroup(), forKey: "deselectAnimationGroup")
                        radioButton1_2.deselect()
                    }
                    baseView1.layer.add(selectAnimationGroup(), forKey: "selectAnimationGroup")
                    radioButton1_1.select()
                }
            case 2:
                if radioButton1_2.isSelected {
                    baseView2.layer.add(deselectAnimationGroup(), forKey: "deselectAnimationGroup")
                    radioButton1_2.deselect()
                } else {
                    if radioButton1_1.isSelected {
                        baseView1.layer.add(deselectAnimationGroup(), forKey: "deselectAnimationGroup")
                        radioButton1_1.deselect()
                    }
                    baseView2.layer.add(selectAnimationGroup(), forKey: "selectAnimationGroup")
                    radioButton1_2.select()
                }
            default:
                break
            }
        }
    }
    
    
    // MARK: - Animation
    /// RadioButton1を配置しているbaseViewを選択状態に変化させるアニメーショングループを返却する
    /// - Returns: アニメーショングループ
    func selectAnimationGroup() -> CAAnimationGroup {
        let group = CAAnimationGroup()
        
        let borderColor = CABasicAnimation(keyPath: "borderColor")
        borderColor.fromValue = UIColor.rgb(r: 230, g: 230, b: 230, alpha: 1).cgColor
        borderColor.toValue = UIColor.rgb(r: 0, g: 159, b: 225, alpha: 1).cgColor
        
        let backgroundColor = CABasicAnimation(keyPath: "backgroundColor")
        backgroundColor.fromValue = C03_COLOR.cgColor
        backgroundColor.toValue = UIColor.rgb(r: 0, g: 159, b: 225, alpha: 0.1).cgColor
        
        group.animations = [borderColor, backgroundColor]
        group.duration = 0.3
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        
        return group
    }
    
    /// RadioButton1を配置しているbaseViewを選択状態に変化させるアニメーショングループを返却する
    /// - Returns: アニメーショングループ
    func deselectAnimationGroup() -> CAAnimationGroup {
        let group = CAAnimationGroup()
        
        let borderColor = CABasicAnimation(keyPath: "borderColor")
        borderColor.fromValue = UIColor.rgb(r: 0, g: 159, b: 225, alpha: 1).cgColor
        borderColor.toValue = UIColor.rgb(r: 230, g: 230, b: 230, alpha: 1).cgColor
        
        let backgroundColor = CABasicAnimation(keyPath: "backgroundColor")
        backgroundColor.fromValue = UIColor.rgb(r: 0, g: 159, b: 225, alpha: 0.1).cgColor
        backgroundColor.toValue = C03_COLOR.cgColor
        
        group.animations = [borderColor, backgroundColor]
        group.duration = 0.3
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        
        return group
    }
    
    /// RadioButton1を配置しているbaseViewの枠線の色を選択状態にするアニメーション
    /// - Returns: アニメーション
    func borderColorAnimationSelect() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = UIColor.rgb(r: 230, g: 230, b: 230, alpha: 1).cgColor
        animation.toValue = UIColor.rgb(r: 0, g: 159, b: 225, alpha: 1).cgColor
        animation.duration = 0.3
        
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        return animation
    }
    
    /// RadioButton1を配置しているbaseViewの枠線の色を非選択状態にするアニメーション
    /// - Returns: アニメーション
    func borderColorAnimationDeselect() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = UIColor.rgb(r: 0, g: 159, b: 225, alpha: 1).cgColor
        animation.toValue = UIColor.rgb(r: 230, g: 230, b: 230, alpha: 1).cgColor
        animation.duration = 0.3
        
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        return animation
    }
}


class RadioButton1: UIView {
    
    // MARK: - Member
    /// 選択時の色で塗りつぶす用の円
    let circle: UIView = UIView()
    /// 拡大、縮小される用の円
    let innerCircle: UIView = UIView()
    
    /// 枠線の太さ
    private var borderWidth: CGFloat?
    /// 選択時、非選択時の色
    private var selectedColor: UIColor = UIColor.rgb(r: 0, g: 159, b: 225, alpha: 1)
    private var deselectedColor: UIColor = UIColor.rgb(r: 230, g: 230, b: 230, alpha: 1)
    /// 現在選択されているかどうか
    public private(set) var isSelected = false
    
    
    // MARK: - Init
    init(
        diameter: CGFloat,
        selectedColor: UIColor? = nil,
        deselectedColor: UIColor? = nil
    ) {
        let size = CGSize(width: diameter, height: diameter)
        super.init(frame: CGRect(origin: .zero, size: size))
        
        self.borderWidth = diameter / 10
        
        if let selectedColor {
            self.selectedColor = selectedColor
        }
        if let deselectedColor {
            self.deselectedColor = deselectedColor
        }
        
        viewLoad(diameter: diameter)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ViewLoad
    func viewLoad(diameter: CGFloat) {
        let radius = diameter / 2
        let center = CGPoint(x: radius, y: radius)
        
        backgroundColor = .clear
        
        addSubview(circle)
        circle.backgroundColor = self.selectedColor
        circle.layer.cornerRadius = radius
        circle.frame.size = CGSize(width: diameter, height: diameter)
        circle.center = center
        
        addSubview(innerCircle)
        innerCircle.backgroundColor = .white
        innerCircle.layer.cornerRadius = radius
        innerCircle.layer.borderColor = self.deselectedColor.cgColor
        innerCircle.layer.borderWidth = self.borderWidth!
        innerCircle.frame.size = CGSize(width: diameter, height: diameter)
        innerCircle.center = center
    }
    
    
    // MARK: - Action
    /// ラジオボタンを選択状態にする
    /// - Parameter animated: アニメーションの有り無し（true: あり、false: なし）
    func select(animated: Bool = true) {
        // ラジオボタンの選択状態の設定
        guard !isSelected else { return }
        isSelected = true
        innerCircle.layer.add(innerCircleAnimationGroupSelect(), forKey: "innerCircleAnimationGroupSelect")
    }
    
    /// ラジオボタンを非選択状態にする
    /// - Parameter animated: アニメーションの有り無し（true: あり、false: なし）
    func deselect(animated: Bool = true) {
        // ラジオボタンの選択状態の設定
        guard isSelected else { return }
        isSelected = false
        innerCircle.layer.add(innerCircleAnimationGroupDeselect(), forKey: "innerCircleAnimationGroupDeselect")
    }
    
    
    // MARK: - Selected Animation
    func innerCircleAnimationGroupSelect() -> CAAnimationGroup {
        let group = CAAnimationGroup()
        
        let borderWidthAnime = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnime.fromValue = borderWidth
        borderWidthAnime.toValue = 0.0
        
        let scaleAnime = CABasicAnimation(keyPath: "transform.scale")
        scaleAnime.fromValue = 1.0
        scaleAnime.toValue = 0.4
        
        
        group.duration = 0.3
        group.animations = [borderWidthAnime, scaleAnime]
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        return group
    }
    
    
    // MARK: - DeSelected Animation
    func innerCircleAnimationGroupDeselect() -> CAAnimationGroup {
        let group = CAAnimationGroup()
        
        let borderWidthAnime = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnime.fromValue = 0.0
        borderWidthAnime.toValue = borderWidth
        
        let scaleAnime = CABasicAnimation(keyPath: "transform.scale")
        scaleAnime.fromValue = 0.4
        scaleAnime.toValue = 1
        
        group.duration = 0.3
        group.animations = [borderWidthAnime, scaleAnime]
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        return group
    }
    
}
