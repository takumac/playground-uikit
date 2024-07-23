//
//  UIApplication+Extension.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/07/23.
//

import UIKit

extension UIApplication {
    // 現在有効なSceneのWindowScene
    var windowScene: UIWindowScene? {
        if let windowScene = connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            return windowScene
        } else {
            return connectedScenes.first as? UIWindowScene
        }
    }
    
    // 現在のKeyWindow
    var keyWindow: UIWindow? {
        if let keyWindow = windowScene?.windows.first(where: { $0.isKeyWindow }) {
            return keyWindow
        } else {
            return windowScene?.windows.first
        }
    }
}
