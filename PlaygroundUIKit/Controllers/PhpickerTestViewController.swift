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
        // タイトル設定
        self.title = "PHPicker"
        // 画面描画
        viewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Viewload
    func viewLoad() {
        // 画面Viewの生成
        let view = PhpickerTestView()
        view.delegate = self
        phpickerTestView = view
        self.view.addSubview(view)
        // 画面ViewのAutoLayout
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
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
        picker.dismiss(animated: true) { [weak self] () in
            guard let self = self else { return }
            
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
                provider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { [weak self] url, error in
                    guard let self = self else { return }
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
                        DispatchQueue.main.async { [weak self] () in
                            guard let self = self else { return }
                            self.phpickerTestView?.imageView.image = imageData
                        }
                    }
                }
            }
        }
    }
    
}
