//
//  SpeechBubbleTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2025/12/16.
//

import UIKit

// MARK: - SpeechBubbleTestView
class SpeechBubbleTestView: UIView {
    
    // MARK: - Member
    let scrollView: UIScrollView = UIScrollView()
    let scrollContentView: UIView = UIView()
    let speechBubble: SpeechBubble = {
        let label1Str = "2次元コードを表示しますか？\n（2次元コードはボタンの下に表示されます）\n\n表示から30日以内に発送手続の完了が必要です。"
        let label1AttrStr: NSMutableAttributedString = NSMutableAttributedString(string: label1Str)
        
        let paragraph1 = NSMutableParagraphStyle()
        paragraph1.alignment = .center
        paragraph1.lineHeightMultiple = 1.3
        label1AttrStr.addAttribute(
            .paragraphStyle,
            value: paragraph1,
            range: NSMakeRange(0, 14)
        )
        label1AttrStr.addAttribute(
            .paragraphStyle,
            value: paragraph1,
            range: NSMakeRange(15, 21)
        )
        // 行間設定、文字寄せ2
        let paragraph2 = NSMutableParagraphStyle()
        paragraph2.alignment = .left
        paragraph2.lineHeightMultiple = 1.3
        label1AttrStr.addAttribute(
            .paragraphStyle,
            value: paragraph2,
            range: NSMakeRange(38, 23)
        )
        // 文字設定1
        label1AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            range: NSMakeRange(0, 14)
        )
        // 文字設定2
        label1AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W3, size: 16) as Any,
            range: NSMakeRange(15, 21)
        )
        // 文字設定3
        label1AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.black
        ], range: NSMakeRange(38, 4))
        // 文字設定4
        label1AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.red,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.red,
        ], range: NSMakeRange(42, 5))
        // 文字設定5
        label1AttrStr.addAttributes([
            .font: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.black
        ], range: NSMakeRange(47, 8))
        // 文字設定6
        label1AttrStr.addAttribute(
            .font,
            value: UIFont(name: HIRAGINO_KAKU_GOTHIC_W6, size: 20) as Any,
            range: NSMakeRange(55, 6)
        )
        
        
        let speechBubble = SpeechBubble(
            text: "ああああああああああああああaaaaaあああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ",
            attrText: label1AttrStr,
            fillColor: UIColor(red: 255/255, green: 251/255, blue: 198/255, alpha: 1.0),
            strokeColor: UIColor(red: 242/255, green: 234/255, blue: 128/255, alpha: 1.0),
            arrowPosition: .bottom,
            arrowType: .curve,
            arrowOffsetRatio: 0.7,
            arrowHeight: 20,
            arrowWidthLeft: 64,
            arrowWidthRight: 32
        )
        return speechBubble
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - viewLoad
    func viewLoad() {
        // 各UIの初期設定
        setupUI()
        // レイアウト設定
        setupConstraint()
    }
    
    /// 各UIの初期設定を行う
    private func setupUI() {
    }
    
    /// UIの制約設定
    private func setupConstraint() {
        scrollContentView.addSubview(speechBubble)
        scrollView.addSubview(scrollContentView)
        self.addSubview(scrollView)
        
        // MARK: AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        speechBubble.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            speechBubble.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 100),
            speechBubble.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: -100),
            speechBubble.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 16),
            speechBubble.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -16),
//            speechBubble.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
        ])
    }
}


// MARK: - SpeechBubble
class SpeechBubble: UIView {

    // MARK: - Member
    /// 枠線用のレイヤー
    private let shapeLayer = CAShapeLayer()
    
    // ラベル
    /// 文言表示ラベル
    private let label = UILabel()
    /// 文言テキスト
    private let text: String
    /// 文言フォント
    private let font: UIFont
    /// 文言文字色
    private let textColor: UIColor
    /// 文言テキスト（修飾済み）
    private let attrText: NSAttributedString?
    
    // 吹き出しUI
    /// 吹き出し内の余白
    private let contentInsets: UIEdgeInsets
    /// 吹き出しの角丸
    private let cornerRadius: CGFloat
    /// 吹き出しの色
    private let fillColor: UIColor
    /// 吹き出しの枠線の色
    private let strokeColor: UIColor
    /// 吹き出しの枠線の幅
    private let lineWidth: CGFloat
    
    // 矢印
    /// 矢印の位置
    private let arrowPosition: ArrowPosition
    /// 矢印の種類
    private let arrowType: ArrowType
    /// 矢印の描画位置
    private let arrowOffsetRatio: CGFloat
    /// 矢印の高さ
    private let arrowHeight: CGFloat
    /// 矢印の中心から左の幅
    private let arrowWidthLeft: CGFloat
    /// 矢印の中心から右の幅
    private let arrowWidthRight: CGFloat
    

    // MARK: - Init
    /// 初期化
    /// ・描画は反時計回りに行われる（左上→右上→右下→左下）
    /// ・矢印の位置は上下左右の中から設定可能
    /// ・矢印の描画位置を設定すると、矢印の位置で設定した辺で描画方向に対して設定値分移動した箇所が矢印の頂点となる ※0.0〜1.0で設定
    /// ・矢印の中心からの左右の幅は、矢印の位置を上にした時を基準として設定する（矢印の位置が下、左の幅が10、右の幅が20の場合、描画される矢印としては左の幅が20、右の幅が10となる）
    ///
    /// - Parameters:
    ///   - text: 文言テキスト
    ///   - font: 文言フォント
    ///   - textColor: 文言文字色
    ///   - attrText: 文言テキスト（修飾済み）
    ///   - contentInsets: 吹き出し内の余白
    ///   - cornerRadius: 吹き出しの角丸
    ///   - fillColor: 吹き出しの色
    ///   - strokeColor: 吹き出しの枠線の色
    ///   - lineWidth: 吹き出しの枠線の幅
    ///   - arrowPosition: 矢印の位置
    ///   - arrowType: 矢印の種類
    ///   - arrowOffsetRatio: 矢印の描画位置（0〜1）
    ///   - arrowHeight: 矢印の高さ
    ///   - arrowWidthLeft: 矢印の中心から左の幅
    ///   - arrowWidthRight: 矢印の中心から右の幅
    init(
        text: String,
        font: UIFont = .systemFont(ofSize: 16),
        textColor: UIColor = .black,
        attrText: NSAttributedString? = nil,
        contentInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12),
        cornerRadius: CGFloat = 12,
        fillColor: UIColor,
        strokeColor: UIColor,
        lineWidth: CGFloat = 1,
        arrowPosition: ArrowPosition = .bottom,
        arrowType: ArrowType = .straight,
        arrowOffsetRatio: CGFloat = 0.5,
        arrowHeight: CGFloat = 8,
        arrowWidthLeft: CGFloat = 8,
        arrowWidthRight: CGFloat = 8
    ) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.attrText = attrText
        self.contentInsets = contentInsets
        self.cornerRadius = cornerRadius
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.arrowPosition = arrowPosition
        self.arrowType = arrowType
        self.arrowOffsetRatio = arrowOffsetRatio
        self.arrowHeight = arrowHeight
        self.arrowWidthLeft = arrowWidthLeft
        self.arrowWidthRight = arrowWidthRight
        super.init(frame: .zero)
        
        viewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Override
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.bounds.size != .zero else { return }
        shapeLayer.frame = self.bounds
        shapeLayer.path = makePath(rect: self.bounds).cgPath
    }
    
    
    // MARK: - ViewLoad
    private func viewLoad() {
        // 各UIの初期設定
        setupUI()
        // レイアウト設定
        setupConstraint()
    }
    
    /// 各UIの初期設定を行う
    private func setupUI() {
        self.backgroundColor = .clear
        
        // ラベル
        label.font = font
        label.textColor = textColor
        if let attrText = attrText, !attrText.string.isEmpty {
            label.attributedText = attrText
        } else {
            let attrText = NSMutableAttributedString(string: text)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            attrText.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: NSMakeRange(0, attrText.length)
            )
            label.attributedText = attrText
        }
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        
        // 吹き出しUI
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
    }
    
    /// UIの制約設定
    private func setupConstraint() {
        self.layer.addSublayer(shapeLayer)
        self.addSubview(label)
        
        // MARK: AutoLayout
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: contentInsets.top + (arrowPosition == .top ? arrowHeight : 0)),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentInsets.left + (arrowPosition == .left ? arrowHeight : 0)),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(contentInsets.right + (arrowPosition == .right ? arrowHeight : 0))),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(contentInsets.bottom + (arrowPosition == .bottom ? arrowHeight : 0)))
        ])
    }
    
    
    // MARK: - Common
    /// 吹き出し全体（角丸＋矢印）を描画するためのパスを生成する
    /// - Parameter rect: パス生成の基準となる矩形（AutoLayout確定後のbounds）
    /// - Returns: 吹き出し形状を表すUIBezierPath
    private func makePath(rect: CGRect) -> UIBezierPath {
        let body: CGRect = {
            switch arrowPosition {
            case .top:
                return CGRect(
                    x: rect.minX,
                    y: rect.minY + arrowHeight,
                    width: rect.width,
                    height: rect.height - arrowHeight
                )
            case .bottom:
                return CGRect(
                    x: rect.minX,
                    y: rect.minY,
                    width: rect.width,
                    height: rect.height - arrowHeight
                )
            case .left:
                return CGRect(
                    x: rect.minX + arrowHeight,
                    y: rect.minY,
                    width: rect.width - arrowHeight,
                    height: rect.height
                )
            case .right:
                return CGRect(
                    x: rect.minX,
                    y: rect.minY,
                    width: rect.width - arrowHeight,
                    height: rect.height
                )
            }
        }()
        let radius = min(cornerRadius, min(body.width, body.height) / 2)
        let curveCpRatio = ArrowCurveCpRatio.pattern1
        
        // 吹き出しUI描画開始
        let path = UIBezierPath()
        
        // スタート地点に移動
        path.move(to: CGPoint(x: body.minX + radius, y: body.minY))
        
        // 上辺
        if arrowPosition == .top {
            // 上矢印の場合
            let arrowTip = CGPoint(x: body.minX + body.width * arrowOffsetRatio, y: body.minY - arrowHeight)
            let arrowStart = CGPoint(x: arrowTip.x - arrowWidthLeft, y: body.minY)
            let arrowEnd = CGPoint(x: arrowTip.x + arrowWidthRight, y: body.minY)
            // 矢印のタイプによって描画を切り分ける
            switch arrowType {
            case .straight:
                // 直線
                path.addLine(to: arrowStart)
                path.addLine(to: arrowTip)
                path.addLine(to: arrowEnd)
                path.addLine(to: CGPoint(x: body.maxX - radius, y: body.minY))
            case .curve:
                // 曲線
                path.addLine(to: arrowStart)
                if arrowWidthLeft > 0 {
                    let cp1 = CGPoint(
                        x: arrowStart.x + arrowWidthLeft * curveCpRatio.start.cp1X,
                        y: arrowStart.y - arrowHeight * curveCpRatio.start.cp1Y
                    )
                    let cp2 = CGPoint(
                        x: arrowStart.x + arrowWidthLeft * curveCpRatio.start.cp2X,
                        y: arrowStart.y - arrowHeight * curveCpRatio.start.cp2Y
                    )
                    path.addCurve(to: arrowTip, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    path.addLine(to: arrowTip)
                }
                if arrowWidthRight > 0 {
                    let cp1 = CGPoint(
                        x: arrowEnd.x - arrowWidthRight * curveCpRatio.end.cp1X,
                        y: arrowEnd.y - arrowHeight * curveCpRatio.end.cp1Y
                    )
                    let cp2 = CGPoint(
                        x: arrowEnd.x - arrowWidthRight * curveCpRatio.end.cp2X,
                        y: arrowEnd.y - arrowHeight * curveCpRatio.end.cp2Y
                    )
                    path.addCurve(to: arrowEnd, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    path.addLine(to: arrowEnd)
                }
                path.addLine(to: CGPoint(x: body.maxX - radius, y: body.minY))
            }
        } else {
            path.addLine(to: CGPoint(x: body.maxX - radius, y: body.minY))
        }
        
        // 右上角丸
        path.addArc(
            withCenter: CGPoint(x: body.maxX - radius, y: body.minY + radius),
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: 0,
            clockwise: true
        )
        
        // 右辺
        if arrowPosition == .right {
            // 右矢印の場合
            let arrowTip = CGPoint(x: body.maxX + arrowHeight, y: body.minY + body.height * arrowOffsetRatio)
            let arrowStart = CGPoint(x: body.maxX, y: arrowTip.y - arrowWidthLeft)
            let arrowEnd = CGPoint(x: body.maxX, y: arrowTip.y + arrowWidthRight)
            // 矢印のタイプによって描画を切り分ける
            switch arrowType {
            case .straight:
                // 直線
                path.addLine(to: arrowStart)
                path.addLine(to: arrowTip)
                path.addLine(to: arrowEnd)
                path.addLine(to: CGPoint(x: body.maxX, y: body.maxY - radius))
            case .curve:
                // 曲線
                path.addLine(to: arrowStart)
                if arrowWidthLeft > 0 {
                    let cp1 = CGPoint(
                        x: arrowStart.x + arrowHeight * curveCpRatio.start.cp1Y,
                        y: arrowStart.y + arrowWidthLeft * curveCpRatio.start.cp1X
                    )
                    let cp2 = CGPoint(
                        x: arrowStart.x + arrowHeight * curveCpRatio.start.cp2Y,
                        y: arrowStart.y + arrowWidthLeft * curveCpRatio.start.cp2X
                    )
                    path.addCurve(to: arrowTip, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    path.addLine(to: arrowTip)
                }
                if arrowWidthRight > 0 {
                    let cp1 = CGPoint(
                        x: arrowEnd.x + arrowHeight * curveCpRatio.end.cp1Y,
                        y: arrowEnd.y - arrowWidthRight * curveCpRatio.end.cp1X
                    )
                    let cp2 = CGPoint(
                        x: arrowEnd.x + arrowHeight * curveCpRatio.end.cp2Y,
                        y: arrowEnd.y - arrowWidthRight * curveCpRatio.end.cp2X
                    )
                    path.addCurve(to: arrowEnd, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    path.addLine(to: arrowEnd)
                }
                path.addLine(to: CGPoint(x: body.maxX, y: body.maxY - radius))
            }
        } else {
            path.addLine(to: CGPoint(x: body.maxX, y: body.maxY - radius))
        }
        
        // 右下角丸
        path.addArc(
            withCenter: CGPoint(x: body.maxX - radius, y: body.maxY - radius),
            radius: radius,
            startAngle: 0,
            endAngle: .pi / 2,
            clockwise: true
        )
        
        // 下辺
        if arrowPosition == .bottom {
            // 下矢印の場合
            let arrowTip = CGPoint(x: body.maxX - body.width * arrowOffsetRatio, y: body.maxY + arrowHeight)
            let arrowStart = CGPoint(x: arrowTip.x + arrowWidthLeft, y: body.maxY)
            let arrowEnd = CGPoint(x: arrowTip.x - arrowWidthRight, y: body.maxY)
            // 矢印のタイプによって描画を切り分ける
            switch arrowType {
            case .straight:
                // 直線
                path.addLine(to: arrowStart)
                path.addLine(to: arrowTip)
                path.addLine(to: arrowEnd)
                path.addLine(to: CGPoint(x: body.minX + radius, y: body.maxY))
            case .curve:
                // 曲線
                path.addLine(to: arrowStart)
                if arrowWidthLeft > 0 {
                    let cp1 = CGPoint(
                        x: arrowStart.x - arrowWidthLeft * curveCpRatio.start.cp1X,
                        y: arrowStart.y + arrowHeight * curveCpRatio.start.cp1Y
                    )
                    let cp2 = CGPoint(
                        x: arrowStart.x - arrowWidthLeft * curveCpRatio.start.cp2X,
                        y: arrowStart.y + arrowHeight * curveCpRatio.start.cp2Y
                    )
                    path.addCurve(to: arrowTip, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    path.addLine(to: arrowTip)
                }
                if arrowWidthRight > 0 {
                    let cp1 = CGPoint(
                        x: arrowEnd.x + arrowWidthRight * curveCpRatio.end.cp1X,
                        y: arrowEnd.y + arrowHeight * curveCpRatio.end.cp1Y
                    )
                    let cp2 = CGPoint(
                        x: arrowEnd.x + arrowWidthRight * curveCpRatio.end.cp2X,
                        y: arrowEnd.y + arrowHeight * curveCpRatio.end.cp2Y
                    )
                    path.addCurve(to: arrowEnd, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    path.addLine(to: arrowEnd)
                }
                path.addLine(to: CGPoint(x: body.minX + radius, y: body.maxY))
            }
        } else {
            path.addLine(to: CGPoint(x: body.minX + radius, y: body.maxY))
        }
        
        // 左下角丸
        path.addArc(
            withCenter: CGPoint(x: body.minX + radius, y: body.maxY - radius),
            radius: radius,
            startAngle: .pi / 2,
            endAngle: .pi,
            clockwise: true
        )
        
        // 左辺
        if arrowPosition == .left {
            // 右矢印の場合
            let arrowTip = CGPoint(x: body.minX - arrowHeight, y: body.maxY - body.height * arrowOffsetRatio)
            let arrowStart = CGPoint(x: body.minX, y: arrowTip.y + arrowWidthLeft)
            let arrowEnd = CGPoint(x: body.minX, y: arrowTip.y - arrowWidthRight)
            // 矢印のタイプによって描画を切り分ける
            switch arrowType {
            case .straight:
                // 直線
                path.addLine(to: arrowStart)
                path.addLine(to: arrowTip)
                path.addLine(to: arrowEnd)
                path.addLine(to: CGPoint(x: body.minX, y: body.minY + radius))
            case .curve:
                // 曲線
                path.addLine(to: arrowStart)
                if arrowWidthLeft > 0 {
                    let cp1 = CGPoint(
                        x: arrowStart.x - arrowHeight * curveCpRatio.start.cp1Y,
                        y: arrowStart.y - arrowWidthLeft * curveCpRatio.start.cp1X
                    )
                    let cp2 = CGPoint(
                        x: arrowStart.x - arrowHeight * curveCpRatio.start.cp2Y,
                        y: arrowStart.y - arrowWidthLeft * curveCpRatio.start.cp2X
                    )
                    path.addCurve(to: arrowTip, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    path.addLine(to: arrowTip)
                }
                if arrowWidthRight > 0 {
                    let cp1 = CGPoint(
                        x: arrowEnd.x - arrowHeight * curveCpRatio.end.cp1Y,
                        y: arrowEnd.y + arrowWidthRight * curveCpRatio.end.cp1X
                    )
                    let cp2 = CGPoint(
                        x: arrowEnd.x - arrowHeight * curveCpRatio.end.cp2Y,
                        y: arrowEnd.y + arrowWidthRight * curveCpRatio.end.cp2X
                    )
                    path.addCurve(to: arrowEnd, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    path.addLine(to: arrowEnd)
                }
                path.addLine(to: CGPoint(x: body.minX, y: body.minY + radius))
            }
        } else {
            path.addLine(to: CGPoint(x: body.minX, y: body.minY + radius))
        }
        
        // 左上角丸
        path.addArc(
            withCenter: CGPoint(x: body.minX + radius, y: body.minY + radius),
            radius: radius,
            startAngle: .pi,
            endAngle: -.pi / 2,
            clockwise: true
        )
        
        path.close()
        return path
    }
}

// MARK: - ArrowPosition
/// 矢印の位置
enum ArrowPosition {
    /// 上
    case top
    /// 下
    case bottom
    /// 左
    case left
    /// 右
    case right
}

// MARK: - ArrowType
/// 矢印のタイプ
enum ArrowType {
    /// 直線
    case straight
    /// 曲線
    case curve
}

// MARK: - ArrowCurveCpRatio
/// 矢印のタイプが「curve」の際のcp1とcp2の倍率
/// 矢印の位置が「上下」の場合はXとYはそのまま設定で良いが、「左右」の場合はXとYを反転して設定する ※軸の概念が反転するため
private struct ArrowCurveCpRatio {
    struct Start {
        let cp1X: CGFloat
        let cp1Y: CGFloat
        let cp2X: CGFloat
        let cp2Y: CGFloat
    }
    
    struct End {
        let cp1X: CGFloat
        let cp1Y: CGFloat
        let cp2X: CGFloat
        let cp2Y: CGFloat
    }
    
    let start: Start
    let end: End
    
    static let pattern1 = ArrowCurveCpRatio(
        start: .init(cp1X: 0.3, cp1Y: 0.1, cp2X: 0.7, cp2Y: 0.3),
        end: .init(cp1X: 0.7, cp1Y: 0.3, cp2X: 0.3, cp2Y: 0.1)
    )
}

