//
//  SizeConstant.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/06/21.
//

import Foundation
import UIKit

let SCREEN_SIZE: CGSize = UIScreen.main.bounds.size // 画面の大きさ
let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width // 画面の横幅
let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height // 画面の高さ
let windowScene: UIWindowScene = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first!
let STATUSBAR_HEIGHT: CGFloat = windowScene.statusBarManager?.statusBarFrame.height ?? 0 // ステータスバーの高さ

let MODAL_VIEW_HEIGHT: CGFloat  = SCREEN_HEIGHT - STATUSBAR_HEIGHT // モーダルビューの高さ
let MODELESS_VIEW_HEIGHT: CGFloat = MODAL_VIEW_HEIGHT // モーダレスビューの高さ
let MODAL_VIEW_FRAME: CGRect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MODAL_VIEW_HEIGHT) // モーダルビューのCGRect
let MODELESS_VIEW_FRAME: CGRect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: MODELESS_VIEW_HEIGHT) // モーダレスビューのCGRect
