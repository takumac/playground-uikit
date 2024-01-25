//
//  AccordionButtonTestView.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/08/04.
//

import Foundation
import UIKit

class AccordionButtonTestView: UIView, UIGestureRecognizerDelegate {
    
    var scrollView: UIScrollView = UIScrollView()
    var contentView: UIStackView = UIStackView()
    
    // アコーディオンボタン1（ジェスチャーがデフォルト）
    var accordionButton: AccordionButton?
    let headerView: UIView = UIView()
    let headerLabel: UILabel = UILabel()
    let headerImage: UIImageView = UIImageView()
    let bodyView: UIView = UIView()
    let bodyLabel: UILabel = UILabel()
    
    // アコーディオンボタン2（ジェスチャーがデフォルト以外）
    let accordionButton2Background: UIView = UIView()
    var accordionButton2: AccordionButton?
    let headerView2: UIView = UIView()
    let headerLabel2: UILabel = UILabel()
    let headerImage2: UIImageView = UIImageView()
    let bodyView2: UIView = UIView()
    let bodyLabel2: UILabel = UILabel()
    
    
    var isAccordionOpen: Bool = true
    var isAccordionOpen2: Bool = true
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLoad
    func viewLoad() {
        
        // MARK: アコーディオンボタン1（ジェスチャーがデフォルト）
        headerLabel.text = "アコーディオンボタン1"
        headerLabel.font = UIFont(name: "HiraKakuProN-W6", size: 16)
        headerLabel.sizeToFit()
        headerImage.image = UIImage(named: "minus-icon")
        let headerViewTapGestureParent = UITapGestureRecognizer(target: self, action: #selector(headerViewTapActionParent))
        headerViewTapGestureParent.delegate = self
        headerView.addGestureRecognizer(headerViewTapGestureParent)
        headerView.addSubview(headerLabel)
        headerView.addSubview(headerImage)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        headerImage.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        headerImage.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        
        bodyLabel.font = UIFont(name: "HiraKakuProN-W3", size: 14)
        
        let string1 = "領収書の発行に関して以下をご確認の上、申請をお願い致します。\n"
        let string2 = "・約束メモ番号とは「#」で始まる番号です。領収書を発行したい取引の約束メモの番号をご入力ください。"
        let string3 = "＜入力例＞"
        let string4 = "(例) #12345、#12346、#12347、･･･"
        let string5 = "・領収書はメールに添付してご送付します。正しいメールアドレスのご登録をお願い致します。"
        let string6 = "・領収書の発行は申請から数日のお時間をいただいております。申請状況等により、発行にお時間がかかる場合がございます。予めご了承の上、ご利用ください。"
        
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let label4 = UILabel()
        let label5 = UILabel()
        let label6 = UILabel()
        
        let bullet = "・"
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont(name: "HiraKakuProN-W6", size: 14)
        
        // string1について
        label1.font = UIFont(name: "HiraKakuProN-W3", size: 14)
        label1.numberOfLines = 0
        label1.lineBreakMode = .byCharWrapping
        
        let attributedString1: NSMutableAttributedString = NSMutableAttributedString(string: string1)
        let paragraphStyle1 = NSMutableParagraphStyle()
        paragraphStyle1.lineHeightMultiple = 1.3
        attributedString1.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle1,
                                       range: NSMakeRange(0, attributedString1.length))
        label1.attributedText = attributedString1
        label1.sizeToFit()
        bodyView.addSubview(label1)
        
        // string2について
        let attributedString2: NSMutableAttributedString = NSMutableAttributedString(string: string2)
        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        paragraphStyle2.lineHeightMultiple = 1.3
        attributedString2.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle2,
                                       range: NSMakeRange(0, string2.count))
        // 太字とアンダーライン
        attributedString2.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.boldSystemFont(ofSize: 14),
            range: NSMakeRange(0,20)
        )
        attributedString2.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSMakeRange(1,20)
        )
        
        label2.font = UIFont(name: "HiraKakuProN-W3", size: 14)
        label2.numberOfLines = 0
        label2.lineBreakMode = .byCharWrapping
        label2.attributedText = attributedString2
        label2.sizeToFit()
        bodyView.addSubview(label2)
        
        // string3について
        let attributedString3: NSMutableAttributedString = NSMutableAttributedString(string: string3)
        let paragraphStyle3 = NSMutableParagraphStyle()
        paragraphStyle3.firstLineHeadIndent = (bullet as NSString).size(withAttributes: attributes).width
        paragraphStyle3.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        paragraphStyle3.lineHeightMultiple = 1.3
        attributedString3.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle3,
                                       range: NSMakeRange(0, attributedString3.length))
        
        label3.font = UIFont(name: "HiraKakuProN-W3", size: 14)
        label3.numberOfLines = 0
        label3.lineBreakMode = .byCharWrapping
        label3.attributedText = attributedString3
        label3.sizeToFit()
        bodyView.addSubview(label3)
        
        // string4について
        let attributedString4: NSMutableAttributedString = NSMutableAttributedString(string: string4)
        let paragraphStyle4 = NSMutableParagraphStyle()
        paragraphStyle4.firstLineHeadIndent = (bullet as NSString).size(withAttributes: attributes).width
        paragraphStyle4.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        paragraphStyle4.lineHeightMultiple = 1.3
        attributedString4.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle4,
                                       range: NSMakeRange(0, attributedString4.length))
        
        label4.font = UIFont(name: "HiraKakuProN-W3", size: 14)
        label4.numberOfLines = 0
        label4.lineBreakMode = .byCharWrapping
        label4.attributedText = attributedString4
        label4.sizeToFit()
        bodyView.addSubview(label4)
        
        // string5について
        let attributedString5: NSMutableAttributedString = NSMutableAttributedString(string: string5)
        let paragraphStyle5 = NSMutableParagraphStyle()
        paragraphStyle5.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        paragraphStyle5.lineHeightMultiple = 1.3
        attributedString5.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle5,
                                       range: NSMakeRange(0, attributedString5.length))
        // 太字とアンダーライン
        attributedString5.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.boldSystemFont(ofSize: 14),
            range: NSMakeRange(0,19)
        )
        attributedString5.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSMakeRange(1,19)
        )
        
        label5.font = UIFont(name: "HiraKakuProN-W3", size: 14)
        label5.numberOfLines = 0
        label5.lineBreakMode = .byCharWrapping
        label5.attributedText = attributedString5
        label5.sizeToFit()
        bodyView.addSubview(label5)
        
        // string6について
        let attributedString6: NSMutableAttributedString = NSMutableAttributedString(string: string6)
        let paragraphStyle6 = NSMutableParagraphStyle()
        paragraphStyle6.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        paragraphStyle6.lineHeightMultiple = 1.3
        attributedString6.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle6,
                                       range: NSMakeRange(0, attributedString6.length))
        attributedString6.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.boldSystemFont(ofSize: 14),
            range: NSMakeRange(0,1)
        )
        
        label6.font = UIFont(name: "HiraKakuProN-W3", size: 14)
        label6.numberOfLines = 0
        label6.lineBreakMode = .byCharWrapping
        label6.attributedText = attributedString6
        label6.sizeToFit()
        bodyView.addSubview(label6)
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 5).isActive = true
        label1.widthAnchor.constraint(equalTo: bodyView.widthAnchor, multiplier: 1).isActive = true
        label1.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor).isActive = true
        label2.widthAnchor.constraint(equalTo: bodyView.widthAnchor, multiplier: 1).isActive = true
        label2.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.topAnchor.constraint(equalTo: label2.bottomAnchor).isActive = true
        label3.widthAnchor.constraint(equalTo: bodyView.widthAnchor, multiplier: 1).isActive = true
        label3.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.topAnchor.constraint(equalTo: label3.bottomAnchor).isActive = true
        label4.widthAnchor.constraint(equalTo: bodyView.widthAnchor, multiplier: 1).isActive = true
        label4.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.topAnchor.constraint(equalTo: label4.bottomAnchor).isActive = true
        label5.widthAnchor.constraint(equalTo: bodyView.widthAnchor, multiplier: 1).isActive = true
        label5.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        label6.translatesAutoresizingMaskIntoConstraints = false
        label6.topAnchor.constraint(equalTo: label5.bottomAnchor).isActive = true
        label6.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -5).isActive = true
        label6.widthAnchor.constraint(equalTo: bodyView.widthAnchor, multiplier: 1).isActive = true
        label6.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        accordionButton = AccordionButton(headerView: headerView,
                                          bodyView: bodyView,
                                          initShowBody: isAccordionOpen,
                                          isShowSeparator: true)
        accordionButton?.setAutoLayout()
        accordionButton?.setBorder(borderColor: .lightGray, borderWidth: 1.0, cornerRadius: 5.0)
        accordionButton?.setSeparatorColor(separatorColor: .gray)
        accordionButton?.setShadow(shadowOffset: CGSize(width: 0.0, height: 3.0),
                                   shadowOpacity: 0.2,
                                   shadowRadius: 3.0)
        contentView.addSubview(accordionButton!)
        
        // MARK: - アコーディオンボタン2（ジェスチャーがデフォルト以外）
        headerLabel2.text = "アコーディオンボタン2"
        headerLabel2.font = UIFont(name: "HiraKakuProN-W6", size: 16)
        headerLabel2.sizeToFit()
        headerImage2.image = UIImage(named: "minus-icon")
        let headerImageTapGestureParent = UITapGestureRecognizer(target: self, action: #selector(headerImageTapActionParent(_:)))
        headerImage2.isUserInteractionEnabled = true
        headerImage2.addGestureRecognizer(headerImageTapGestureParent)
        
        headerView2.addSubview(headerLabel2)
        headerView2.addSubview(headerImage2)
        
        headerLabel2.translatesAutoresizingMaskIntoConstraints = false
        headerLabel2.topAnchor.constraint(equalTo: headerView2.topAnchor, constant: 15).isActive = true
        headerLabel2.bottomAnchor.constraint(equalTo: headerView2.bottomAnchor, constant: -15).isActive = true
        headerLabel2.leadingAnchor.constraint(equalTo: headerView2.leadingAnchor, constant: 10).isActive = true
        
        headerImage2.translatesAutoresizingMaskIntoConstraints = false
        headerImage2.centerYAnchor.constraint(equalTo: headerView2.centerYAnchor).isActive = true
        headerImage2.trailingAnchor.constraint(equalTo: headerView2.trailingAnchor, constant: -10).isActive = true
        
        bodyLabel2.text = "ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ"
        bodyLabel2.font = UIFont(name: "HiraKakuProN-W6", size: 16)
        bodyLabel2.numberOfLines = 0
        bodyLabel2.lineBreakMode = .byWordWrapping
        bodyLabel2.sizeToFit()
        
        bodyView2.addSubview(bodyLabel2)
        
        bodyLabel2.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel2.topAnchor.constraint(equalTo: bodyView2.topAnchor, constant: 10).isActive = true
        bodyLabel2.bottomAnchor.constraint(equalTo: bodyView2.bottomAnchor, constant: -10).isActive = true
        bodyLabel2.leadingAnchor.constraint(equalTo: bodyView2.leadingAnchor, constant: 10).isActive = true
        bodyLabel2.trailingAnchor.constraint(equalTo: bodyView2.trailingAnchor, constant: -10).isActive = true
        
        accordionButton2 = AccordionButton(headerView: headerView2,
                                           bodyView: bodyView2,
                                           initShowBody: isAccordionOpen2,
                                           isShowSeparator: true,
                                           isDefaultGesture: false)
        accordionButton2?.setCustomAutoLayout()
        accordionButton2?.setBorder(borderColor: .lightGray, borderWidth: 1.0, cornerRadius: 5.0)
        accordionButton2?.setSeparatorColor(separatorColor: .gray)
        accordionButton2?.setShadow(shadowOffset: CGSize(width: 0.0, height: 3.0),
                                    shadowOpacity: 0.2,
                                    shadowRadius: 3.0)
        
        accordionButton2Background.backgroundColor = .red
        accordionButton2Background.addSubview(accordionButton2!)
        contentView.addSubview(accordionButton2Background)
        
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        
        
        // MARK: - AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        
        accordionButton?.translatesAutoresizingMaskIntoConstraints = false
        accordionButton?.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        accordionButton?.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        accordionButton?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        accordionButton2Background.translatesAutoresizingMaskIntoConstraints = false
        accordionButton2Background.topAnchor.constraint(equalTo: accordionButton!.bottomAnchor, constant: 50).isActive = true
        accordionButton2Background.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        accordionButton2Background.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        accordionButton2?.translatesAutoresizingMaskIntoConstraints = false
        accordionButton2?.topAnchor.constraint(equalTo: accordionButton2Background.topAnchor, constant: 20).isActive = true
        accordionButton2?.bottomAnchor.constraint(equalTo: accordionButton2Background.bottomAnchor, constant: -20).isActive = true
        accordionButton2?.widthAnchor.constraint(equalTo: accordionButton2Background.widthAnchor, multiplier: 0.8).isActive = true
        accordionButton2?.centerXAnchor.constraint(equalTo: accordionButton2Background.centerXAnchor).isActive = true
        
        accordionButton2Background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100).isActive = true
        
    }
    
    
    // MARK: - Action
    @objc func headerViewTapActionParent(_ sender: UITapGestureRecognizer) {
        if isAccordionOpen {
            isAccordionOpen = !isAccordionOpen
            headerImage.image = UIImage(named: "plus-icon")
        } else {
            isAccordionOpen = !isAccordionOpen
            headerImage.image = UIImage(named: "minus-icon")
        }
    }
    
    @objc func headerImageTapActionParent(_ sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView {
            if isAccordionOpen2 {
                isAccordionOpen2 = !isAccordionOpen2
                accordionButton2?.externalAccordionAction()
                tappedImageView.image = UIImage(named: "plus-icon")
            } else {
                isAccordionOpen2 = !isAccordionOpen2
                accordionButton2?.externalAccordionAction()
                tappedImageView.image = UIImage(named: "minus-icon")
            }
        }
    }
    
    
    // MARK: - Delegate(UIGestureRecognizerDelegate)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}


class AccordionButton: UIView {
    // MARK: - Member
    let containerView: UIStackView = UIStackView()
    var headerView: UIView?
    var bodyView: UIView?
    var separatorView: UIView?
    
    var isShowBody: Bool?
    var isShowSeparator: Bool?
    var isDefaultGesture: Bool?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// 初期化処理
    /// - Parameters:
    ///   - headerView: ヘッダ用のView
    ///   - bodyView: ボディ用のView
    ///   - initShowBody: ボディ表示有無の初期値
    ///   - isShowSeparator: 区切り線の表示有無
    ///   - isDefaultGesture: デフォルトジェスチャーを採用するかどうか（true: ヘッダーのViewタップでジェスチャー着火、false: 呼び出し側で動かす必要がある）
    convenience init(headerView: UIView,
                     bodyView: UIView,
                     initShowBody: Bool = true,
                     isShowSeparator: Bool = false,
                     isDefaultGesture: Bool = true) {
        self.init()
        
        self.headerView = headerView
        self.bodyView = bodyView
        self.bodyView!.isHidden = !initShowBody
        self.isShowBody = initShowBody
        self.isShowSeparator = isShowSeparator
        
        if isDefaultGesture {
            // ヘッダーのジェスチャーを設定
            let headerViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapAction))
            self.headerView?.addGestureRecognizer(headerViewTapGesture)
        }
        
        // コンテナビューの設定
        containerView.axis = .vertical
        containerView.alignment = .center
        containerView.distribution = .equalSpacing
        // コンテナビューに配置
        containerView.addArrangedSubview(self.headerView!)
        containerView.addArrangedSubview(self.bodyView!)
        
        // ヘッダーとボディーの区切り線を設定
        if self.isShowSeparator! {
            separatorView = UIView()
            separatorView?.backgroundColor = .lightGray
            self.addSubview(separatorView!)
        }
        
        self.addSubview(containerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - AutoLayout
    /// デフォルトでいい感じのAutoLayoutを設定する
    func setAutoLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        headerView!.translatesAutoresizingMaskIntoConstraints = false
        headerView!.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        headerView!.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
        headerView!.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        if self.isShowSeparator! {
            separatorView?.translatesAutoresizingMaskIntoConstraints = false
            separatorView?.topAnchor.constraint(equalTo: headerView!.bottomAnchor, constant: -1.0).isActive = true
            separatorView?.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.95).isActive = true
            separatorView?.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            separatorView?.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
            
            bodyView!.translatesAutoresizingMaskIntoConstraints = false
            bodyView!.topAnchor.constraint(equalTo: separatorView!.bottomAnchor).isActive = true
        } else {
            bodyView!.translatesAutoresizingMaskIntoConstraints = false
            bodyView!.topAnchor.constraint(equalTo: headerView!.bottomAnchor).isActive = true
        }
        bodyView!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        bodyView!.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
        bodyView!.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    /// 呼び出し元で設定されたヘッダーとフッターのAutoLayoutを優先した上でアコーディオンボタン全体のAutoLayoutを設定する
    func setCustomAutoLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        headerView!.translatesAutoresizingMaskIntoConstraints = false
        headerView!.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        headerView!.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        headerView!.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        if self.isShowSeparator! {
            separatorView?.translatesAutoresizingMaskIntoConstraints = false
            separatorView?.topAnchor.constraint(equalTo: headerView!.bottomAnchor, constant: -1.0).isActive = true
            separatorView?.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.95).isActive = true
            separatorView?.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            separatorView?.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
            
            bodyView!.translatesAutoresizingMaskIntoConstraints = false
            bodyView!.topAnchor.constraint(equalTo: separatorView!.bottomAnchor).isActive = true
        } else {
            bodyView!.translatesAutoresizingMaskIntoConstraints = false
            bodyView!.topAnchor.constraint(equalTo: headerView!.bottomAnchor).isActive = true
        }
        bodyView!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        bodyView!.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        bodyView!.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    
    // MARK: - Common
    /// 枠線の設定を行う
    /// - Parameters:
    ///   - borderColor: 枠線の色
    ///   - borderWidth: 枠線の太さ
    ///   - cornerRadius: 角丸の値
    func setBorder(borderColor: UIColor = .lightGray, borderWidth: CGFloat = 1.0, cornerRadius: CGFloat = 0.0) {
        containerView.layer.borderColor = borderColor.cgColor
        containerView.layer.borderWidth = borderWidth
        containerView.layer.cornerRadius = cornerRadius
        
        // View自体の角丸も同じ値で設定する
        self.layer.cornerRadius = cornerRadius
    }
    
    /// ヘッダとボディの区切り線の色を設定する
    /// - Parameter separatorColor: 区切り線の色
    func setSeparatorColor(separatorColor: UIColor = .lightGray) {
        if isShowSeparator! {
            separatorView?.backgroundColor = separatorColor
        }
    }
    
    /// 影を設定する
    /// - Parameters:
    ///   - shadowOffset: 影の位置
    ///   - shadowColor: 影の色
    ///   - shadowOpacity: 影の透明度
    ///   - shadowRadius: 影のぼかし度
    ///   - backgroundColor: View自体の背景色
    func setShadow(shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0),
                   shadowColor: UIColor = .black,
                   shadowOpacity: Float = 1.0,
                   shadowRadius: CGFloat = 0.0,
                   backgroundColor: UIColor = .white) {
        // 子部品に影がつかないようにView自体に背景色を設定
        self.backgroundColor = backgroundColor
        // 影を設定
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
    
    
    // MARK: - Action
    /// デフォルトジェスチャー（ヘッダーViewタップ時）用のアクション
    /// - Parameter sender: ヘッダーViewのインスタンス
    @objc func headerViewTapAction(_ sender: UIView) {
        isShowBody = !isShowBody!
        if isShowSeparator! {
            UIView.animate(withDuration: 0.25) {
                self.bodyView?.isHidden = !self.isShowBody!
                self.separatorView?.isHidden = !self.isShowBody!
            }
        } else {
            UIView.animate(withDuration: 0.25) {
                self.bodyView?.isHidden = !self.isShowBody!
            }
        }
    }
    
    /// 外部から好きなタイミングでアコーディオン操作をするためのアクション
    func externalAccordionAction() {
        isShowBody = !isShowBody!
        if isShowSeparator! {
            UIView.animate(withDuration: 0.25) {
                self.bodyView?.isHidden = !self.isShowBody!
                self.separatorView?.isHidden = !self.isShowBody!
            }
        } else {
            UIView.animate(withDuration: 0.25) {
                self.bodyView?.isHidden = !self.isShowBody!
            }
        }
    }
}

