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
    ///   - align: 指定したいalign
    ///   - lineHeightMultiple: 指定したいlineHeightMultiple
    /// - Returns: 解析した結果のAttributedString
    func htmlToAttributedString(
        withFont: UIFont? = nil,
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
            
            // AttributedStringの加工（アラインメント、フォントの設定）
            // ※HTMLデータからパースしたてのAttributedStringだとフォントが元と違ったり、アラインメントが左に固定されているため
            let fullRange = NSRange(location: 0, length: attributedText.length)
            let mutableAttributeText = NSMutableAttributedString(attributedString: attributedText)
            // アラインメント
            let style = NSMutableParagraphStyle()
            style.alignment = align
            style.lineHeightMultiple = lineHeightMultiple
            mutableAttributeText.addAttribute(.paragraphStyle, value: style, range: fullRange)
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
}
