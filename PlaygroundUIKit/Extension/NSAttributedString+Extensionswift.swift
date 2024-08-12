//
//  NSAttributedString+Extensionswift.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/08/10.
//

import UIKit

extension NSAttributedString {
    func getCustomActionRanges() -> [NSRange] {
        var ranges: [NSRange] = []
        self.enumerateAttribute(.customAction, in: NSRange(location: 0, length: self.length)) { (value, range, _) in
            if value != nil {
                ranges.append(range)
            }
        }
        return ranges
    }
}

// カスタム属性を定義
extension NSAttributedString.Key {
    static let customAction = NSAttributedString.Key("customAction")
}
