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
        let speechBubble = SpeechBubble(
            text: "あああああ",
            arrowPosition: .top,
            arrowType: .curve,
            arrowBaseLeft: 10,
            arrowHeight: 20,
            arrowBaseRight: 32
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
    let label = UILabel()

    // MARK: - Config
    private let contentInsets: UIEdgeInsets
    private let cornerRadius: CGFloat

    private let arrowPosition: ArrowPosition
    private let arrowType: ArrowType
    private let arrowOffsetRatio: CGFloat

    /// 矢印の移動量（すべて init で受け取る）
    private let arrowBaseLeft: CGFloat?
    private let arrowHeight: CGFloat?
    private let arrowBaseRight: CGFloat?

    private let fillColor: UIColor
    private let strokeColor: UIColor
    private let lineWidth: CGFloat

    // MARK: - Layer
    private let shapeLayer = CAShapeLayer()

    // MARK: - Init
    init(
        text: String,

        arrowPosition: ArrowPosition = .bottom,
        arrowType: ArrowType = .straight,
        arrowOffsetRatio: CGFloat = 0.5,

        arrowBaseLeft: CGFloat? = nil,
        arrowHeight: CGFloat? = nil,
        arrowBaseRight: CGFloat? = nil,

        contentInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12),
        cornerRadius: CGFloat = 10,

        fillColor: UIColor = UIColor(red: 1.0, green: 0.98, blue: 0.88, alpha: 1.0),
        strokeColor: UIColor = UIColor(red: 0.93, green: 0.80, blue: 0.28, alpha: 1.0),
        lineWidth: CGFloat = 1
    ) {
        self.contentInsets = contentInsets
        self.cornerRadius = cornerRadius

        self.arrowPosition = arrowPosition
        self.arrowType = arrowType
        self.arrowOffsetRatio = arrowOffsetRatio

        self.arrowBaseLeft = arrowBaseLeft
        self.arrowHeight = arrowHeight
        self.arrowBaseRight = arrowBaseRight

        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth

        super.init(frame: .zero)

        label.text = text
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setup() {
        backgroundColor = .clear

        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        layer.addSublayer(shapeLayer)
        
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        addSubview(label)
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.frame = bounds
        shapeLayer.path = makePath(in: bounds).cgPath

        let arrowH = arrowHeight ?? 0
        let labelY = arrowPosition == .top ? contentInsets.top + arrowH : contentInsets.top
        let labelHeight = bounds.height - contentInsets.top - contentInsets.bottom - arrowH
        let labelWidth = bounds.width - contentInsets.left - contentInsets.right
        label.preferredMaxLayoutWidth = labelWidth
        invalidateIntrinsicContentSize()
        
        label.frame = CGRect(
            x: contentInsets.left,
            y: labelY,
            width: labelWidth,
            height: labelHeight
        )
    }

    override var intrinsicContentSize: CGSize {
        // 幅が決まっていればそれを使う（複数行対応）
        let maxLabelWidth: CGFloat
        if bounds.width > 0 {
            maxLabelWidth = bounds.width - contentInsets.left - contentInsets.right
        } else {
            maxLabelWidth = CGFloat.greatestFiniteMagnitude
        }

        let labelSize = label.sizeThatFits(
            CGSize(
                width: maxLabelWidth,
                height: CGFloat.greatestFiniteMagnitude
            )
        )

        let arrowH = arrowHeight ?? 0

        return CGSize(
            width: labelSize.width + contentInsets.left + contentInsets.right,
            height: labelSize.height + contentInsets.top + contentInsets.bottom + arrowH
        )
    }


    // MARK: - Path
    private func makePath(in rect: CGRect) -> UIBezierPath {

        let arrowH = arrowHeight ?? 0

        let body: CGRect = {
            switch arrowPosition {
            case .top:
                return CGRect(
                    x: rect.minX,
                    y: rect.minY + arrowH,
                    width: rect.width,
                    height: rect.height - arrowH
                )
            case .bottom:
                return CGRect(
                    x: rect.minX,
                    y: rect.minY,
                    width: rect.width,
                    height: rect.height - arrowH
                )
            }
        }()

        let r = min(cornerRadius, min(body.width, body.height) / 2)
        let p = UIBezierPath()
        
        let bl = arrowBaseLeft ?? 0
        let br = arrowBaseRight ?? 0
        let h  = arrowHeight ?? 0

        // ===== top edge (start) =====
        p.move(to: CGPoint(x: body.minX + r, y: body.minY))

        if arrowPosition == .top {
            // 上矢印の場合
            let tip = CGPoint(x: body.minX + body.width * arrowOffsetRatio, y: body.minY - h)
            let arrowStart = CGPoint(x: tip.x - bl, y: body.minY)
            let arrowEnd = CGPoint(x: tip.x + br, y: body.minY)
            switch arrowType {
            case .straight:
                p.addLine(to: arrowStart)
                p.addLine(to: tip)
                p.addLine(to: arrowEnd)
                p.addLine(to: CGPoint(x: body.maxX - r, y: body.minY))
            case .curve:
                p.addLine(to: arrowStart)
                if bl > 0 {
                    let cp1 = CGPoint(x: arrowStart.x + bl * 0.3, y: arrowStart.y - h * 0.1)
                    let cp2 = CGPoint(x: arrowStart.x + bl * 0.7, y: arrowStart.y - h * 0.3)
                    p.addCurve(to: tip, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    p.addLine(to: tip)
                }
                if br > 0 {
                    let cp1 = CGPoint(x: arrowEnd.x - br * 0.7, y: arrowEnd.y - h * 0.3)
                    let cp2 = CGPoint(x: arrowEnd.x - br * 0.3, y: arrowEnd.y - h * 0.1)
                    p.addCurve(to: arrowEnd, controlPoint1: cp1, controlPoint2: cp2)
                } else {
                    p.addLine(to: arrowEnd)
                }
                p.addLine(to: CGPoint(x: body.maxX - r, y: body.minY))
            }
        } else {
            // 通常の上辺
            p.addLine(to: CGPoint(x: body.maxX - r, y: body.minY))
        }

        p.addArc(
            withCenter: CGPoint(x: body.maxX - r, y: body.minY + r),
            radius: r,
            startAngle: -.pi / 2,
            endAngle: 0,
            clockwise: true
        )

        // ===== right edge =====
        p.addLine(to: CGPoint(x: body.maxX, y: body.maxY - r))
        p.addArc(
            withCenter: CGPoint(x: body.maxX - r, y: body.maxY - r),
            radius: r,
            startAngle: 0,
            endAngle: .pi / 2,
            clockwise: true
        )

        // ===== bottom edge + arrow =====
        if arrowPosition == .bottom {
            // 下矢印の場合
            let baseX = body.maxX - body.width * arrowOffsetRatio

            // 矢印開始まで（右 → 左に進む）
            let arrowStart = CGPoint(
                x: baseX - (arrowBaseLeft ?? 0),
                y: body.maxY
            )
            p.addLine(to: arrowStart)

            // 矢印の頂点まで（下へ）
            let tip = CGPoint(
                x: arrowStart.x,
                y: arrowStart.y + (arrowHeight ?? 0)
            )
            p.addLine(to: tip)

            // 矢印終了まで（さらに左へ）
            let arrowEnd = CGPoint(
                x: tip.x - (arrowBaseRight ?? 0),
                y: body.maxY
            )
            p.addLine(to: arrowEnd)

            // 下辺の終了まで
            p.addLine(to: CGPoint(x: body.minX + r, y: body.maxY))
        } else {
            // 通常の下辺
            p.addLine(to: CGPoint(x: body.minX + r, y: body.maxY))
        }


        p.addArc(
            withCenter: CGPoint(x: body.minX + r, y: body.maxY - r),
            radius: r,
            startAngle: .pi / 2,
            endAngle: .pi,
            clockwise: true
        )

        // ===== left edge =====
        p.addLine(to: CGPoint(x: body.minX, y: body.minY + r))
        p.addArc(
            withCenter: CGPoint(x: body.minX + r, y: body.minY + r),
            radius: r,
            startAngle: .pi,
            endAngle: -.pi / 2,
            clockwise: true
        )
        
        p.close()
        return p
    }
}


// MARK: - ArrowPosition
/// 吹き出しの矢印の位置
enum ArrowPosition {
    case top
    case bottom
}

enum ArrowType {
    case straight
    case curve
}
