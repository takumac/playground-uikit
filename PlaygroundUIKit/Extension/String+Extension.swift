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
    
    
    /// オリジナルのタグを管理するためのEnum
    private enum CustomTagStyle {
        /// 太字
        case bold
        /// 下線
        case underline
        /// 文字色（パラメタ：16進数表記のカラーコード）
        case color(String)
    }
    
    /// オリジナルで定義したタグによって修飾されたAttributedStringを返却する
    /// - Parameters:
    ///   - withFontSize: 指定したいフォントサイズ
    ///   - withBoldFont: 指定したいフォント
    ///   - lineHeightMultiple: 指定したい行間
    /// - Returns: タグを解析した結果の修飾されたAttributedString
    func customTagtoAttributedString(
        withFontSize: CGFloat,
        withBoldFont: UIFont? = nil,
        lineHeightMultiple: CGFloat = 1.0
    ) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        
        // 修飾対象の位置を取得するためのパターン文字列
        let tagPatternAll =
        "<bold>(.*?)</bold>" +
        "|<underline>(.*?)</underline>" +
        "|<color=\"#([0-9A-Fa-f]{6})\">(.*?)</color>"
        
        // 各タグの正規表現
        let tagPatterns: [String : CustomTagStyle] = [
            "<bold>(.*?)</bold>" : .bold,
            "<underline>(.*?)</underline>" : .underline,
            "<color=\"#([0-9A-Fa-f]{6})\">(.*?)</color>" : .color("")
        ]
        
        // 正規表現用変数
        guard let regexAll = try? NSRegularExpression(pattern: tagPatternAll, options: []) else {
            return attributedString
        }
        
        // 変換前の全てのテキスト
        let textAll = attributedString.string
        
        // 変換前の全てのテキストの中で、指定したタグが設定されている場所の一覧
        // ※タグがネストされている場合は一番外側のタグ基準
        let matches = regexAll.matches(
            in: textAll,
            range: NSRange(
                location: 0,
                length: textAll.utf8.count
            )
        )
        
        // 最終的に返却する編集後のAttributedString
        let editAllAttrStr = NSMutableAttributedString(string: self)
        var editAllStr = attributedString.string
        
        // 編集結果として設定するスタイル、範囲を保持する変数
        var applyStyles : [[CustomTagStyle]] = []
        var applyRanges : [NSRange] = []
        
        // 各修飾箇所を1箇所ずつ前から順に編集していく
        for _ in 0..<matches.count {
            
            guard let firstMatch = regexAll.firstMatch(
                in: editAllStr,
                range: NSRange(
                    location: 0,
                    length: editAllStr.utf8.count
                )
            ) else {
                continue
            }
            
            // 現在編集している修飾箇所を保持する変数
            var editPartialStr = (editAllStr as NSString).substring(with: firstMatch.range)
            let editPartialAttrStr = NSMutableAttributedString(string: editPartialStr)
            var applyStyle: [CustomTagStyle] = []
            
            // どのスタイルにマッチしているか走査する
            for (pattern, style) in tagPatterns {
                guard let regexPartial = try? NSRegularExpression(pattern: pattern, options: [])  else {
                    continue
                }
                guard let match = regexPartial.firstMatch(
                    in: editPartialStr,
                    range: NSRange(
                        location: 0,
                        length: editPartialStr.utf8.count
                    )
                ) else {
                    continue
                }
                
                // マッチしたスタイルによって分岐させる
                switch style {
                case .color:
                    // スタイルがカラーの場合
                    // ※カラーの場合は2つの正規表現パターンがある
                    // ※1番目：カラーコードの正規表現パターン
                    // ※2番目：タグに囲まれた中身の正規表現パターン
                    
                    // マッチした範囲を取得
                    let matchRange = match.range
                    // カラーコードの範囲を取得
                    let colorRange = match.range(at: 1)
                    // カラーコードを文字列として取得
                    let colorCodeStr = (editPartialStr as NSString).substring(with: colorRange)
                    // マッチしたタグに囲まれた中身を取得
                    let contentRange = match.range(at: 2)
                    // マッチしたタグの中身を文字列として取得
                    let contentStr = (editPartialStr as NSString).substring(with: contentRange)
                    
                    editPartialAttrStr.replaceCharacters(in: matchRange, with: contentStr)
                    editPartialStr = editPartialAttrStr.string
                    
                    applyStyle.append(.color(colorCodeStr))
                    
                default:
                    // デフォルト挙動
                    
                    // マッチした範囲を取得
                    let matchRange = match.range
                    // マッチしたタグに囲まれた中身を取得
                    let contentRange = match.range(at: 1)
                    // マッチしたタグの中身を文字列として取得
                    let contentStr = (editPartialStr as NSString).substring(with: contentRange)
                    
                    editPartialAttrStr.replaceCharacters(in: matchRange, with: contentStr)
                    editPartialStr = editPartialAttrStr.string
                    
                    applyStyle.append(style)
                }
            }
            
            // 各変数を更新する
            editAllAttrStr.replaceCharacters(in: firstMatch.range, with: editPartialStr)
            editAllStr = editAllAttrStr.string
            applyStyles.append(applyStyle)
            applyRanges.append(NSRange(location: firstMatch.range.location, length: editPartialStr.count))
        }
        
        // スタイルの適用
        for i in 0..<matches.count {
            let styles = applyStyles[i]
            let range = applyRanges[i]
            
            for style in styles {
                switch style {
                case .bold:
                    let boldFont = withBoldFont ?? UIFont.boldSystemFont(ofSize: withFontSize)
                    editAllAttrStr.addAttribute(.font, value: boldFont, range: range)
                case .underline:
                    editAllAttrStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
                case .color(let hex):
                    editAllAttrStr.addAttribute(.foregroundColor, value: UIColor(hex: hex), range: range)
                }
            }
        }
        
        // 行間の設定
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        editAllAttrStr.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(
                location: 0,
                length: editAllAttrStr.length
            )
        )
        
        return editAllAttrStr
    }
    
}
