//
//  String+Extension.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/08/07.
//

import UIKit

extension String {
    /// HTML文字列を解析してNSAttributedStringを返却する
    /// - Parameters:
    ///   - withFont: 指定したいfont
    ///   - withColor: 指定したいcolor
    ///   - align: 指定したいalign
    ///   - lineHeightMultiple: 指定したいlineHeightMultiple
    /// - Returns: 解析した結果のAttributedString
    func htmlToAttributedString(
        withFont: UIFont? = nil,
        withColor: UIColor? = nil,
        align: NSTextAlignment = .left,
        lineHeightMultiple: CGFloat = 1.0
    ) -> NSAttributedString {
        do {
            // 自分自身（文字列）をHTMLデータへUTF8エンコードを行う
            guard let data = self.data(using: .utf8, allowLossyConversion: true) else {
                print("HTML to AttributedString Convert Error")
                return NSAttributedString(string: self)
            }
            // HTMLデータをパースしHTMLタグを考慮したAttributedStringに変換する
            let attributedText = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            
            // AttributedStringの加工
            // ※HTMLデータからパースしたてのAttributedStringだとフォントが元と違ったり、アラインメントが左に固定されているため
            let fullRange = NSRange(location: 0, length: attributedText.length)
            let mutableAttributeText = NSMutableAttributedString(attributedString: attributedText)
            // カラー
            if let color = withColor {
                mutableAttributeText.addAttribute(.foregroundColor, value: color, range: fullRange)
            }
            // アラインメント、ライン幅
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = align
            paragraphStyle.lineHeightMultiple = lineHeightMultiple
            mutableAttributeText.addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)
            // フォント
            if let font = withFont {
                // パラメタでフォントが設定されている場合のみ
                // HTMLからパースした結果のAttibutedStringの「.font」が設定されている箇所を基準に分割して走査する
                // 「こんにちは、今日は<br>天気</br>がいい。」というHTML文字列をパースした場合
                // ・こんにちは、今日は
                // ・天気
                // ・がいい。
                // 上記のように分割され、3回usingの中が呼ばれる
                mutableAttributeText.enumerateAttribute(
                    .font,
                    in: fullRange,
                    options: .longestEffectiveRangeNotRequired,
                    using: { attribute, range, _ in
                        // 分割された部分のfontを取得する
                        if let attributeFont = attribute as? UIFont {
                            // 分割された部分のfontの情報を保持
                            let traits: UIFontDescriptor.SymbolicTraits = attributeFont.fontDescriptor.symbolicTraits
                            // パラメタで指定されたfontの属性を取得
                            var newDescriptor = attributeFont.fontDescriptor.withFamily(font.familyName)
                            // 太字、斜め文字の判定には2進数でのビット演算を用いて分割された部分が修飾対象かどうか判定する
                            // ※分割された部分を2進数に直した時に該当箇所に1が立っているかどうかで判断
                            // 太字の判定
                            if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0 {
                                // 分割された部分のfontが太字対象の場合
                                if let descriptor = newDescriptor.withSymbolicTraits(.traitBold) {
                                    // パラメタで指定されたfontに太字が設定可能であれば修飾を行う
                                    newDescriptor = descriptor
                                }
                            }
                            // 斜め文字の判定
                            if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) != 0 {
                                // 分割された部分のfontが斜め文字対象の場合
                                if let descriptor = newDescriptor.withSymbolicTraits(.traitItalic) {
                                    // パラメタで指定されたfontに斜め文字が設定可能であれば修飾を行う
                                    newDescriptor = descriptor
                                }
                            }
                            
                            let scaledFont = UIFont(descriptor: newDescriptor, size: attributeFont.pointSize)
                            mutableAttributeText.addAttribute(.font, value: scaledFont, range: range)
                    }
                })
            }
            
            return mutableAttributeText
            
        } catch {
            print("HTML to AttributedString Convert Error")
            return NSAttributedString(string: self)
        }
    }
    
    
    /// オリジナルで定義したタグによって修飾されたAttributedStringを返却する
    /// - Parameters:
    ///   - withFont: 指定したいフォント
    ///   - actionCount: <action>タグの解析のために内部的に必要な変数（！！！必ず0を指定！！！）
    /// - Returns: タグを解析した結果の修飾されたAttributedString
    func customTagToAttributedString(
        withFont: UIFont? = nil,
        actionCount: inout Int
    ) -> NSAttributedString {
        // 検索対象の正規表現
        let pattern =
        // フォントサイズ（<fontsize>）
        "<fontsize=\"(\\d+)\">(.*?)</fontsize>" +
        // 太字（<bold>）
        "|<bold>(.*?)</bold>" +
        // 下線（<underline>）
        "|<underline>(.*?)</underline>" +
        // 文字色（<color>）
        "|<color=\"#([0-9A-Fa-f]{6})\">(.*?)</color>" +
        // リスト（<list>）
        "|<list=\"(.*?)\">(.*?)</list>" +
        // オーダーリスト（<orderlist>）
        "|<orderlist>(.*?)</orderlist>" +
        // タップアクション（<action>）
        "|<action>(.*?)</action>"
        
        
        let attributedString = NSMutableAttributedString(string: "")
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators)
            var currentLocation = self.startIndex
            
            let matches = regex.matches(in: self, options: [], range: NSRange(self.startIndex..., in: self))
            
            for match in matches {
                let preMatchRange = currentLocation..<self.index(self.startIndex, offsetBy: match.range.location)
                let preMatchText = String(self[preMatchRange])
                attributedString.append(NSAttributedString(string: preMatchText))
                
                if match.range(at: 2).location != NSNotFound && match.range(at: 1).location != NSNotFound {
                    // <fontsize>タグの処理
                    let fontSizeRange = match.range(at: 1)
                    let fontSizeTextRange = match.range(at: 2)
                    if let sizeRange = Range(fontSizeRange, in: self), let textRange = Range(fontSizeTextRange, in: self) {
                        let fontSize = CGFloat(Double(self[sizeRange]) ?? UIFont.systemFontSize)
                        let fontSizeText = String(self[textRange])
                        
                        let innerAttributedString = fontSizeText.customTagToAttributedString(
                            withFont: withFont,
                            actionCount: &actionCount
                        )
                        let resizedText = NSMutableAttributedString(attributedString: innerAttributedString)
                        
                        resizedText.enumerateAttribute(
                            .font,
                            in: NSRange(location: 0, length: resizedText.length)
                        ) { value, range, _ in
                            if let font = value as? UIFont {
                                // 変換範囲にフォントが設定されている場合
                                let baseFont = font
                                let newFont = baseFont.withSize(fontSize)
                                resizedText.addAttribute(.font, value: newFont, range: range)
                            } else if let withFont = withFont {
                                // デフォルトのフォントが渡されている場合
                                let baseFont = withFont
                                let newFont = baseFont.withSize(fontSize)
                                resizedText.addAttribute(.font, value: newFont, range: range)
                            } else {
                                // システム標準のフォントを使用
                                let baseFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
                                let newFont = baseFont.withSize(fontSize)
                                resizedText.addAttribute(.font, value: newFont, range: range)
                            }
                        }
                        
                        attributedString.append(resizedText)
                    }
                    
                } else if match.range(at: 3).location != NSNotFound {
                    // <bold>タグの処理
                    let boldRange = match.range(at: 3)
                    if let range = Range(boldRange, in: self) {
                        let boldText = String(self[range])
                        let innerAttributedString = boldText.customTagToAttributedString(
                            withFont: withFont,
                            actionCount: &actionCount
                        )
                        let boldedText = NSMutableAttributedString(attributedString: innerAttributedString)
                        
                        boldedText.enumerateAttribute(
                            .font,
                            in: NSRange(location: 0, length: boldedText.length)
                        ) { value, range, _ in
                            if let font = value as? UIFont {
                                // 変換範囲にフォントが設定されている場合
                                if let boldFontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitBold) {
                                    let boldFont = UIFont(descriptor: boldFontDescriptor, size: font.pointSize)
                                    boldedText.addAttribute(.font, value: boldFont, range: range)
                                }
                            } else if let withFont = withFont {
                                // デフォルトのフォントが渡されている場合
                                if let boldFontDescriptor = withFont.fontDescriptor.withSymbolicTraits(.traitBold) {
                                    let boldFont = UIFont(descriptor: boldFontDescriptor, size: withFont.pointSize)
                                    boldedText.addAttribute(.font, value: boldFont, range: range)
                                }
                            } else {
                                // システム標準のフォントを使用
                                boldedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize), range: range)
                            }
                        }
                        
                        attributedString.append(boldedText)
                    }
                    
                } else if match.range(at: 4).location != NSNotFound {
                    // <underline>タグの処理
                    let underlineRange = match.range(at: 4)
                    if let range = Range(underlineRange, in: self) {
                        let underlineText = String(self[range])
                        let innerAttributedString = underlineText.customTagToAttributedString(
                            withFont: withFont,
                            actionCount: &actionCount
                        )
                        let underlinedText = NSMutableAttributedString(attributedString: innerAttributedString)
                        underlinedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: underlinedText.length))
                        attributedString.append(underlinedText)
                    }
                    
                } else if match.range(at: 6).location != NSNotFound && match.range(at: 6).location != NSNotFound {
                    // <color>タグの処理
                    let colorCodeRange = match.range(at: 5)
                    let colorTextRange = match.range(at: 6)
                    if let colorRange = Range(colorCodeRange, in: self), let textRange = Range(colorTextRange, in: self) {
                        let colorCode = String(self[colorRange])
                        let colorText = String(self[textRange])
                        
                        if let color = UIColor(hex: colorCode) {
                            let innerAttributedString = colorText.customTagToAttributedString(
                                withFont: withFont,
                                actionCount: &actionCount
                            )
                            let coloredText = NSMutableAttributedString(attributedString: innerAttributedString)
                            coloredText.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: coloredText.length))
                            attributedString.append(coloredText)
                        }
                    }
                    
                } else if match.range(at: 8).location != NSNotFound && match.range(at: 7).location != NSNotFound {
                    // <list>タグの処理
                    let listPrefixRange = match.range(at: 7)
                    let listItemsRange = match.range(at: 8)
                    if let prefixRange = Range(listPrefixRange, in: self), let itemsRange = Range(listItemsRange, in: self) {
                        let prefix = String(self[prefixRange])
                        let itemsText = String(self[itemsRange])
                        
                        let linePattern = "<line>(.*?)</line>"
                        let lineRegex = try NSRegularExpression(pattern: linePattern)
                        let lineMatches = lineRegex.matches(in: itemsText, range: NSRange(itemsText.startIndex..., in: itemsText))
                        
                        attributedString.append(NSAttributedString(string: "\n"))
                        
                        for (index, lineMatch) in lineMatches.enumerated() {
                            if lineMatch.range(at: 1).location != NSNotFound {
                                if let lineRange = Range(lineMatch.range(at: 1), in: itemsText) {
                                    let lineText = String(itemsText[lineRange])
                                    let lineAttributedString = lineText.customTagToAttributedString(
                                        withFont: withFont,
                                        actionCount: &actionCount
                                    )
                                    
                                    if index > 0 {
                                        attributedString.append(NSAttributedString(string: "\n"))
                                    }
                                    let listItemText = NSMutableAttributedString(string: "\(prefix) ")
                                    listItemText.append(lineAttributedString)
                                    attributedString.append(listItemText)
                                }
                            }
                        }
                        
                        attributedString.append(NSAttributedString(string: "\n"))
                    }
                    
                } else if match.range(at: 9).location != NSNotFound {
                    // <orderlist>タグの処理
                    let orderListRange = match.range(at: 9)
                    if let range = Range(orderListRange, in: self) {
                        let orderListText = String(self[range])
                        
                        let orderLinePattern = "<orderline>(.*?)</orderline>"
                        let orderLineRegex = try NSRegularExpression(pattern: orderLinePattern)
                        let orderLineMatches = orderLineRegex.matches(in: orderListText, range: NSRange(orderListText.startIndex..., in: orderListText))
                        
                        attributedString.append(NSAttributedString(string: "\n"))
                        
                        for (index, orderLineMatch) in orderLineMatches.enumerated() {
                            if orderLineMatch.range(at: 1).location != NSNotFound {
                                if let orderLineRange = Range(orderLineMatch.range(at: 1), in: orderListText) {
                                    let orderLineText = String(orderListText[orderLineRange])
                                    let orderLineAttributedString = orderLineText.customTagToAttributedString(
                                        withFont: withFont,
                                        actionCount: &actionCount
                                    )
                                    
                                    if index > 0 {
                                        attributedString.append(NSAttributedString(string: "\n"))
                                    }
                                    let orderListItemText = NSMutableAttributedString(string: "\(index + 1). ")
                                    orderListItemText.append(orderLineAttributedString)
                                    attributedString.append(orderListItemText)
                                }
                            }
                        }
                        
                        attributedString.append(NSAttributedString(string: "\n"))
                    }
                    
                } else if match.range(at: 10).location != NSNotFound {
                    // <action>タグの処理
                    let actionRange = match.range(at: 10)
                    if let range = Range(actionRange, in: self) {
                        let actionText = String(self[range])
                        let innerAttributedString = actionText.customTagToAttributedString(
                            withFont: withFont,
                            actionCount: &actionCount
                        )
                        let actionAttributedString = NSMutableAttributedString(attributedString: innerAttributedString)
                        
                        actionCount += 1
                        let urlString = "action\(actionCount)"
                        if let url = URL(string: urlString) {
                            actionAttributedString.addAttribute(.link, value: url, range: NSRange(location: 0, length: actionAttributedString.length))
                        }
                        
                        attributedString.append(actionAttributedString)
                    }
                }
                
                currentLocation = self.index(self.startIndex, offsetBy: match.range.location + match.range.length)
            }
            
            let postMatchText = String(self[currentLocation...])
            attributedString.append(NSAttributedString(string: postMatchText))
            
            // フォントが設定されていない部分にデフォルトのフォントを適用
            attributedString.enumerateAttributes(
                in: NSRange(
                    location: 0,
                    length: attributedString.length
                ),
                options: []
            ) { attributes, range, _ in
                if attributes[.font] == nil {
                    attributedString.addAttribute(
                        .font,
                        value: withFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
                        range: range
                    )
                }
            }
            
        } catch {
            print("Regular expression Error: \(error.localizedDescription)")
            return NSAttributedString(string: self)
        }
        
        return attributedString
    }
    
}
