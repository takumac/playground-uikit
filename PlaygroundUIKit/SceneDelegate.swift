//
//  SceneDelegate.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2023/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        print("app init")
        
        // WindowSceneを取得
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // 各Constantsの設定
        // 画面サイズを設定
        SizeConstant.shared.SCREEN_SIZE = windowScene.screen.bounds.size
        // 画面の幅を設定
        SizeConstant.shared.SCREEN_WIDTH = windowScene.screen.bounds.size.width
        // 画面の高さを設定
        SizeConstant.shared.SCREEN_HEIGHT = windowScene.screen.bounds.size.height
        // ステータスバーの高さを設定
        SizeConstant.shared.STATUSBAR_HEIGHT = windowScene.statusBarManager?.statusBarFrame.height ?? 0
        // ナビゲーションバーの高さを取得するためにダミーのインスタンスを作成する
        let dummyRootViewController: RootViewController = RootViewController.init()
        let dummyNavigationController: UINavigationController =
            UINavigationController.init(rootViewController: dummyRootViewController)
        // ナビゲーションバーの高さを設定
        SizeConstant.shared.NAVIGATIONBAR_HEIGHT = dummyNavigationController.navigationBar.frame.size.height
        // モーダルビューの高さを設定
        SizeConstant.shared.MODAL_VIEW_HEIGHT = SizeConstant.shared.SCREEN_HEIGHT - SizeConstant.shared.STATUSBAR_HEIGHT - SizeConstant.shared.NAVIGATIONBAR_HEIGHT
        // モーダルビューの画面フレームを設定
        SizeConstant.shared.MODAL_VIEW_FRAME = CGRect(
            x: 0,
            y: 0,
            width: SizeConstant.shared.SCREEN_WIDTH,
            height: SizeConstant.shared.MODAL_VIEW_HEIGHT
        )
        // モーダレスビューの高さを設定
        SizeConstant.shared.MODELESS_VIEW_HEIGHT = SizeConstant.shared.MODAL_VIEW_HEIGHT
        // モーダレスビューの画面フレームを設定
        SizeConstant.shared.MODELESS_VIEW_FRAME = CGRect(
            x: 0,
            y: 0,
            width: SizeConstant.shared.SCREEN_WIDTH,
            height: SizeConstant.shared.MODELESS_VIEW_HEIGHT
        )
        
        // setup TabBar
        let tabBarAppearance = UITabBarAppearance()
        if #available(iOS 26.0, *) {
            tabBarAppearance.configureWithTransparentBackground()
        } else {
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = .systemBackground
        }
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        if #unavailable(iOS 26.0) {
            UINavigationBar.appearance().isTranslucent = false
        }
        
        // setup NavigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        if #available(iOS 26.0, *) {
            navigationBarAppearance.configureWithTransparentBackground()
        } else {
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = .systemBackground
        }
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        if #unavailable(iOS 26.0) {
            UINavigationBar.appearance().isTranslucent = false
        }
        
        let rootVC = RootTabBarController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootVC
        
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("app delete")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("app active")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("app inactive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("app foreground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("app background")
    }


}

