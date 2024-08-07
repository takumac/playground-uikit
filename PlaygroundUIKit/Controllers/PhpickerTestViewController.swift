//
//  PhpickerTestViewController.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/06/21.
//

import Foundation
import UIKit
import PhotosUI

class PhPickerTestViewController: UIViewController, PhpickerTestViewDelegate, PHPickerViewControllerDelegate {
    
    // MARK: - Member
    var phpickerTestView: PhpickerTestView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色設定
        self.view.backgroundColor = C01_COLOR
        // Navigationbarのタイトル
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .boldSystemFont(ofSize: 25)
        navigationTitleLabel.text = "PhpickerTest"
        navigationTitleLabel.adjustsFontSizeToFitWidth = true
        navigationTitleLabel.sizeToFit()
        navigationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        if let navigationBarHeight = navigationController?.navigationBar.bounds.height {
            navigationTitleLabel.heightAnchor.constraint(equalToConstant: navigationBarHeight).isActive = true
        }
        navigationTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: navigationTitleLabel.bounds.width).isActive = true
        self.navigationItem.titleView = navigationTitleLabel
        
        viewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Viewload
    func viewLoad() {
        phpickerTestView = PhpickerTestView(frame: SizeConstant.shared.MODELESS_VIEW_FRAME)
        phpickerTestView?.phpickerTestViewDelegate = self
        self.view.addSubview(phpickerTestView!)
    }
    
    // MARK: - Delegate(PhpickerTestViewDelegate)
    func phpickerButtonTapAction() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        configuration.preferredAssetRepresentationMode = .current
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.modalPresentationStyle = .fullScreen
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    // MARK: - Delegate(PHPickerViewControllerDelegate)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) {
            // プロバイダーの取得
            guard let provider = results.first?.itemProvider else {
                // キャンセルの場合はプロバイダーが取得できないので、アラートなしでreturn
                return
            }
            
            // ライブ機能撮影の場合エラーとする
            if provider.canLoadObject(ofClass: PHLivePhoto.self) {
                let alert = UIAlertController(title: "エラー", message: "LIVEはNG", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            // 画像がUIImageとして使用可能できない場合はエラーとする
            if !provider.canLoadObject(ofClass: UIImage.self) {
                let alert = UIAlertController(title: "エラー", message: "UIImageとして使えない", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            // URLデータを取得する
            let typeIdentifier = UTType.image.identifier
            if provider.hasItemConformingToTypeIdentifier(typeIdentifier) {
                provider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
                    // URLの取得エラーが発生した場合はエラーとする
                    if error != nil {
                        let alert = UIAlertController(title: "エラー", message: "URL取得時にエラー", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    // URLが取得できた場合は画像情報を取得する
                    if let imageURL = url {
                        // 画像情報が取得できない場合はエラーとする
                        guard let imageData = try? UIImage(data: Data(contentsOf: imageURL)) else {
                            let alert = UIAlertController(title: "エラー", message: "画像情報取得時にエラー", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                        
                        // 画像情報を設定
                        DispatchQueue.main.async {
                            self.phpickerTestView?.imageView.image = imageData
                        }
                    }
                }
            }
        }
    }
    
    
}
