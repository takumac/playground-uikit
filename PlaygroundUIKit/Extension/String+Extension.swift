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
    ///   - withFontSize: 指定したいフォントサイズ
    ///   - withBoldFont: 指定したいフォント
    ///   - lineHeightMultiple: 指定したい行間
    /// - Returns: タグを解析した結果の修飾されたAttributedString
    func customTagToAttributedString(from input: String, actions: [() -> Void]) -> NSAttributedString {
        // 検索対象の正規表現
        let pattern =
        // 太字（<bold>）
        "<bold>(.*?)</bold>" +
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
        var actionIndex = 0
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators)
            var currentLocation = input.startIndex
            
            let matches = regex.matches(in: input, options: [], range: NSRange(input.startIndex..., in: input))
            
            for match in matches {
                // マッチの前の部分を追加
                let preMatchRange = currentLocation..<input.index(input.startIndex, offsetBy: match.range.location)
                let preMatchText = String(input[preMatchRange])
                attributedString.append(NSAttributedString(string: preMatchText))
                
                if match.range(at: 1).location != NSNotFound {
                    // <bold> の処理
                    let boldRange = match.range(at: 1)
                    if let range = Range(boldRange, in: input) {
                        let boldText = String(input[range])
                        let innerAttributedString = customTagToAttributedString(from: boldText, actions: actions)
                        let boldedText = NSMutableAttributedString(attributedString: innerAttributedString)
                        boldedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize), range: NSRange(location: 0, length: boldedText.length))
                        attributedString.append(boldedText)
                    }
                } else if match.range(at: 2).location != NSNotFound {
                    // <underline> の処理
                    let underlineRange = match.range(at: 2)
                    if let range = Range(underlineRange, in: input) {
                        let underlineText = String(input[range])
                        let innerAttributedString = customTagToAttributedString(from: underlineText, actions: actions)
                        let underlinedText = NSMutableAttributedString(attributedString: innerAttributedString)
                        underlinedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: underlinedText.length))
                        attributedString.append(underlinedText)
                    }
                } else if match.range(at: 4).location != NSNotFound && match.range(at: 3).location != NSNotFound {
                    // <color> の処理
                    let colorCodeRange = match.range(at: 3)
                    let colorTextRange = match.range(at: 4)
                    if let colorRange = Range(colorCodeRange, in: input), let textRange = Range(colorTextRange, in: input) {
                        let colorCode = String(input[colorRange])
                        let colorText = String(input[textRange])
                        
                        if let color = UIColor(hex: colorCode) {
                            let innerAttributedString = customTagToAttributedString(from: colorText, actions: actions)
                            let coloredText = NSMutableAttributedString(attributedString: innerAttributedString)
                            coloredText.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: coloredText.length))
                            attributedString.append(coloredText)
                        }
                    }
                } else if match.range(at: 6).location != NSNotFound && match.range(at: 5).location != NSNotFound {
                    // <list> の処理
                    let listPrefixRange = match.range(at: 5)
                    let listItemsRange = match.range(at: 6)
                    if let prefixRange = Range(listPrefixRange, in: input), let itemsRange = Range(listItemsRange, in: input) {
                        let prefix = String(input[prefixRange])
                        let itemsText = String(input[itemsRange])
                        
                        // <line>タグの中身を抽出し、リスト形式に変換
                        let linePattern = "<line>(.*?)</line>"
                        let lineRegex = try NSRegularExpression(pattern: linePattern)
                        let lineMatches = lineRegex.matches(in: itemsText, range: NSRange(itemsText.startIndex..., in: itemsText))
                        
                        for (index, lineMatch) in lineMatches.enumerated() {
                            if lineMatch.range(at: 1).location != NSNotFound {
                                if let lineRange = Range(lineMatch.range(at: 1), in: itemsText) {
                                    let lineText = String(itemsText[lineRange])
                                    let lineAttributedString = customTagToAttributedString(from: lineText, actions: actions)
                                    
                                    if index > 0 {
                                        attributedString.append(NSAttributedString(string: "\n"))
                                    }
                                    let listItemText = NSMutableAttributedString(string: "\(prefix) ")
                                    listItemText.append(lineAttributedString)
                                    attributedString.append(listItemText)
                                }
                            }
                        }
                    }
                } else if match.range(at: 7).location != NSNotFound {
                    // <orderlist> の処理
                    let orderListRange = match.range(at: 7)
                    if let range = Range(orderListRange, in: input) {
                        let orderListText = String(input[range])
                        
                        // <orderline>タグの中身を抽出し、番号付きリスト形式に変換
                        let orderLinePattern = "<orderline>(.*?)</orderline>"
                        let orderLineRegex = try NSRegularExpression(pattern: orderLinePattern)
                        let orderLineMatches = orderLineRegex.matches(in: orderListText, range: NSRange(orderListText.startIndex..., in: orderListText))
                        
                        for (index, orderLineMatch) in orderLineMatches.enumerated() {
                            if orderLineMatch.range(at: 1).location != NSNotFound {
                                if let orderLineRange = Range(orderLineMatch.range(at: 1), in: orderListText) {
                                    let orderLineText = String(orderListText[orderLineRange])
                                    let orderLineAttributedString = customTagToAttributedString(from: orderLineText, actions: actions)
                                    
                                    if index > 0 {
                                        attributedString.append(NSAttributedString(string: "\n"))
                                    }
                                    let orderListItemText = NSMutableAttributedString(string: "\(index + 1). ")
                                    orderListItemText.append(orderLineAttributedString)
                                    attributedString.append(orderListItemText)
                                }
                            }
                        }
                    }
                } else if match.range(at: 8).location != NSNotFound {
                    // <action> の処理
                    let actionRange = match.range(at: 8)
                    if let range = Range(actionRange, in: input), actionIndex < actions.count {
                        let actionText = String(input[range])
                        let innerAttributedString = customTagToAttributedString(from: actionText, actions: actions)
                        let actionAttributedString = NSMutableAttributedString(attributedString: innerAttributedString)
                        actionAttributedString.addAttribute(.customAction, value: actionIndex, range: NSRange(location: 0, length: actionAttributedString.length))
                        attributedString.append(actionAttributedString)
                        actionIndex += 1
                    }
                }
                
                // 現在の位置を更新
                currentLocation = input.index(input.startIndex, offsetBy: match.range.location + match.range.length)
            }
            
            // 最後のマッチ後の部分を追加
            let postMatchText = String(input[currentLocation...])
            attributedString.append(NSAttributedString(string: postMatchText))
            
        } catch {
            print("Invalid regular expression: \(error.localizedDescription)")
            return NSAttributedString(string: input)  // エラーの場合は元の文字列を返す
        }
        
        return attributedString
    }
    
}
