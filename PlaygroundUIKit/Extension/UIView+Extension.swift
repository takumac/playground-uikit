//
//  UIViewExtension.swift
//  Azkari
//
//  Created by mdobashi on 2019/09/02.
//  Copyright © 2019 y.itou. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    
    
    
//    /// ボタンの下に下矢印の記号付きボタン
//    ///
//    /// - Parameters:
//    ///   - view: addSubView先
//    ///   - title: タイトル
//    ///   - target1: ボタンアクションのターゲット
//    ///   - target2: ツールバーのターゲット
//    ///   - action: アクション
//    ///   - topAnchorTager: 決定ボタンを指定して上からの距離を調整（デフォルトはnil）
//    ///   - topConstant: 上からの距離（デフォルトは0）
//    func setNotesButton(view: UIView, title: String, target1: Any?, target2: AnyObject?, action: Selector?, topAnchorTarget: UIButton? = nil, topConstant: CGFloat = 0) {
//        let notesButton:UIButton = UIButton()
//        notesButton.setTitle(title, for: .normal)
//        notesButton.setTitleColor(UIColor.rgb(r: 182, g: 182, b: 182, alpha: 1), for: .normal)
//        if let _action = action {
//            notesButton.addTarget(target1, action: _action, for: .touchUpInside)
//        }
//
//        notesButton.titleLabel?.font = UIFont(name: HIRAGINO_KAKU_GOTHIC_W3, size: 17 * SCREEN_RATE_except_X())
//        notesButton.backgroundColor = UIColor.clear
//        notesButton.sizeToFit()
//
//
//        var ruleBarButtonItem_Bottom:UIBarButtonItem = UIBarButtonItem()  //「▽」アイコン
//        let ruleToolBar_Bottom:UIToolbar = UIToolbar()
//
//        if let _action = action {
//            ruleBarButtonItem_Bottom = UIBarButtonItem(barButtonHiddenItem: .Down, target: target2, action: _action)
//        }
//
//        ruleToolBar_Bottom.tintColor = UIColor.rgb(r: 182, g: 182, b: 182, alpha: 1)
//        ruleToolBar_Bottom.items = [ruleBarButtonItem_Bottom]
//        ruleToolBar_Bottom.isTranslucent = false
//        ruleToolBar_Bottom.clipsToBounds = true
//        ruleToolBar_Bottom.barTintColor = backgroundColor
//        view.addSubview(ruleToolBar_Bottom)
//        view.addSubview(notesButton)
//
//        //「返金についての注意事項」ボタン AutoLayout
//        ruleToolBar_Bottom.translatesAutoresizingMaskIntoConstraints = false
//        //ruleToolBar_Bottom.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40 * SCREEN_RATE_except_X()).isActive = true
//
//        if let target = topAnchorTarget {
//            // TopのtargetButtonが指定されていたら上基準のレイアウト
//            ruleToolBar_Bottom.topAnchor.constraint(equalTo: target.bottomAnchor, constant: topConstant * SCREEN_RATE_except_X()).isActive = true
//        } else {
//            // TopのTargetButtonが指定されていなければ下基準のレイアウト
//            ruleToolBar_Bottom.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40 * SCREEN_RATE_except_X()).isActive = true
//        }
//
//        ruleToolBar_Bottom.widthAnchor.constraint(equalToConstant: 60 * SCREEN_RATE_except_X()).isActive = true
//        ruleToolBar_Bottom.heightAnchor.constraint(equalToConstant: 30 * SCREEN_RATE_except_X()).isActive = true
//        ruleToolBar_Bottom.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//
//        notesButton.translatesAutoresizingMaskIntoConstraints = false
//        notesButton.bottomAnchor.constraint(equalTo: ruleToolBar_Bottom.topAnchor, constant: 10 * SCREEN_RATE_except_X()).isActive = true
//        notesButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        notesButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
//        notesButton.heightAnchor.constraint(equalToConstant: notesButton.height).isActive = true
//    }
    
    /// 一発で親ビューとサイズを合わす
    func ajustForSuperView(target: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: target.topAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: target.rightAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: target.leftAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: target.bottomAnchor).isActive = true
    }
    
    /// 一発で親ビューとサイズを合わせて、なおかつ上下左右のconstantを指定
    /// nilを許容できるようにし、狙った場所だけ指定できるようにする
    func ajustForSuperViewWithConstant(target: UIView, top: CGFloat?, right: CGFloat?, left: CGFloat?, bottom: CGFloat?) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: target.topAnchor, constant: top).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: target.rightAnchor, constant: -right).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: target.leftAnchor, constant: left).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: target.bottomAnchor, constant: -bottom).isActive = true
    }
    }
    
    // 点線・破線を描くメソッド
    func drawDashedLine(color: UIColor, lineWidth: CGFloat, lineSize: NSNumber, spaceSize: NSNumber, type: DashedLineType) {
        let dashedLineLayer: CAShapeLayer = CAShapeLayer()
        dashedLineLayer.frame = self.bounds
        dashedLineLayer.strokeColor = color.cgColor
        dashedLineLayer.lineWidth = lineWidth
        dashedLineLayer.lineDashPattern = [lineSize, spaceSize]
        let path: CGMutablePath = CGMutablePath()
 
        switch type {
 
        case .all:
            dashedLineLayer.fillColor = nil
            dashedLineLayer.path = UIBezierPath(rect: dashedLineLayer.frame).cgPath
        case .top:
            path.move(to: CGPoint(x: 0.0, y: 0.0))
            path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
            dashedLineLayer.path = path
        case .down:
            path.move(to: CGPoint(x: 0.0, y: self.frame.size.height))
            path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
            dashedLineLayer.path = path
        case .right:
            path.move(to: CGPoint(x: self.frame.size.width, y: 0.0))
            path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
            dashedLineLayer.path = path
        case .left:
            path.move(to: CGPoint(x: 0.0, y: 0.0))
            path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
            dashedLineLayer.path = path
        }
        self.layer.addSublayer(dashedLineLayer)
    }
    
    
    /// 上辺に枠線を表示する
    /// - Parameters:
    ///   - color: 枠線の色
    ///   - borderWidth: 枠線の太さ
    func drawTopBorder(color: UIColor, borderWidth: CGFloat) {
        let topBorder = UIView()
        topBorder.backgroundColor = color
        
        self.addSubview(topBorder)
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topBorder.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        topBorder.heightAnchor.constraint(equalToConstant: borderWidth).isActive = true
        
    }
    
    /// 下辺に枠線を表示する
    /// - Parameters:
    ///   - color: 枠線の色
    ///   - borderWidth: 枠線の太さ
    func drawBottomBorder(color: UIColor, borderWidth: CGFloat) {
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = color
        
        self.addSubview(bottomBorder)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomBorder.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: borderWidth).isActive = true
    }
    
}



class NotesButton: UIButton {
    
    
    
    var ruleBarButtonItem_Bottom:UIBarButtonItem = UIBarButtonItem()  //「▽」アイコン
    let ruleToolBar_Bottom:UIToolbar = UIToolbar()
    
    
    var ruleToolBar_barColor: UIColor {
        get {
            return ruleToolBar_Bottom.barTintColor!
        }
        set(color) {
            ruleToolBar_Bottom.barTintColor = color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
//    convenience init(title: String, target1: Any?, target2: AnyObject?, action: Selector?) {
//        self.init()
//
//        setTitle(title, for: .normal)
//        titleLabel?.font = UIFont(name: HIRAGINO_KAKU_GOTHIC_W3, size: 17 * SCREEN_RATE_except_X())
//        setTitleColor(UIColor.rgb(r: 182, g: 182, b: 182, alpha: 1), for: .normal)
//        backgroundColor = UIColor.clear
//        sizeToFit()
//
//
//
//        if let _action = action {
//            addTarget(target1, action: _action, for: .touchUpInside)
//            ruleBarButtonItem_Bottom = UIBarButtonItem(barButtonHiddenItem: .Down, target: target2, action: _action)
//        }
//
//        ruleToolBar_Bottom.tintColor = UIColor.rgb(r: 182, g: 182, b: 182, alpha: 1)
//        ruleToolBar_Bottom.items = [ruleBarButtonItem_Bottom]
//        ruleToolBar_Bottom.isTranslucent = false
//        ruleToolBar_Bottom.clipsToBounds = true
//        ruleToolBar_Bottom.barTintColor = backgroundColor
//        ruleToolBar_Bottom.sizeToFit()
////        addSubview(ruleToolBar_Bottom)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//    func setConstraint(view: UIView) {
//        //「返金についての注意事項」ボタン AutoLayout
//
//
//        translatesAutoresizingMaskIntoConstraints = false
//        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40 * SCREEN_RATE_except_X()).isActive = true
//        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        widthAnchor.constraint(equalToConstant: width).isActive = true
//        heightAnchor.constraint(equalToConstant: height).isActive = true
//
//
//        ruleToolBar_Bottom.translatesAutoresizingMaskIntoConstraints = false
//        ruleToolBar_Bottom.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -5 * SCREEN_RATE_except_X()).isActive = true
//        ruleToolBar_Bottom.widthAnchor.constraint(equalToConstant: 60 * SCREEN_RATE_except_X()).isActive = true
//        ruleToolBar_Bottom.heightAnchor.constraint(equalToConstant: 30 * SCREEN_RATE_except_X()).isActive = true
//        ruleToolBar_Bottom.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    }
    
    
    
    
}

enum DashedLineType {
    case all,top,down,right,left
}
