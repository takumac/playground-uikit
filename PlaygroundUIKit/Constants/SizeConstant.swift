//
//  SizeConstant.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/06/21.
//

import Foundation
import UIKit

final class SizeConstant {
    // MARK: - sharedインスタンス
    static let shared = SizeConstant()
    
    
    // MARK: - init
    private init() { }
    
    
    // MARK: - Constants
    /// 画面の大きさ
    private var _screenSize: CGSize = .zero
    var SCREEN_SIZE: CGSize {
        get { return _screenSize }
        set { _screenSize = newValue }
    }
    
    /// 画面の横幅
    private var _screenWidth: CGFloat = 0.0
    var SCREEN_WIDTH: CGFloat {
        get { return _screenWidth }
        set { _screenWidth = newValue }
    }
    
    /// 画面の高さ
    private var _screenHeight: CGFloat = 0.0
    var SCREEN_HEIGHT: CGFloat {
        get { return _screenHeight }
        set { _screenHeight = newValue }
    }
    
    /// ステータスバーの高さ
    private var _statusBarHeight: CGFloat = 0.0
    var STATUSBAR_HEIGHT: CGFloat {
        get { return _statusBarHeight }
        set { _statusBarHeight = newValue }
    }
    
    /// ナビゲーションバーの高さ
    private var _navigationBarHeight: CGFloat = 44.0
    var NAVIGATIONBAR_HEIGHT: CGFloat {
        get { return _navigationBarHeight }
        set { _navigationBarHeight = newValue }
    }
    
    /// モーダルビューの高さ
    private var _modalViewHeight: CGFloat = 0.0
    var MODAL_VIEW_HEIGHT: CGFloat {
        get { return _modalViewHeight }
        set { _modalViewHeight = newValue }
    }
    
    /// モーダルビューの画面フレーム
    private var _modalViewFrame: CGRect = .zero
    var MODAL_VIEW_FRAME: CGRect {
        get { return _modalViewFrame }
        set { _modalViewFrame = newValue }
    }
    
    /// モーダレスビューの高さ
    private var _modelessViewHeight: CGFloat = 0.0
    var MODELESS_VIEW_HEIGHT: CGFloat {
        get { return _modelessViewHeight }
        set { _modelessViewHeight = newValue }
    }
    
    /// モーダレスビューの画面フレーム
    private var _modelessViewFrame: CGRect = .zero
    var MODELESS_VIEW_FRAME: CGRect {
        get { return _modelessViewFrame }
        set { _modelessViewFrame = newValue }
    }
    
}
