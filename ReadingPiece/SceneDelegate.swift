//
//  SceneDelegate.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/22.
//

import UIKit
import KeychainSwift
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    var timerTime = 0
    var window: UIWindow?
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            
            // 토큰 유무, 검증 결과 따른 루트 뷰 전환
            
            if let token = keychain.get(Keys.token) {
                // 토큰이 있을 경우 검증 진행
                Network.request(req: CheckTokenRequest(token: token)) { result in
                    switch result {
                    case .success(let response):
                        debugPrint(response)
                        if response.code == 1000 {
                            // 토큰이 유효한 경우
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabController")
                            let window = UIWindow(windowScene: windowScene)
                            window.rootViewController = tabBarController
                            self.window = window
                            window.makeKeyAndVisible()
                            window.overrideUserInterfaceStyle = .light
                        }
                    case .cancel, .failure:
                        // 토큰이 유효하지 않을 경우 (ex. 유효기간이 지났을 경우)
                        let storyboard = UIStoryboard(name: "Login", bundle: nil)
                        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginNav")
                        
                        let window = UIWindow(windowScene: windowScene)
                        window.rootViewController = loginViewController
                        self.window = window
                        window.makeKeyAndVisible()
                        window.overrideUserInterfaceStyle = .light
                    }
                }
            } else {
                // 토큰이 없을 경우 (로그인 이력이 없을 경우)
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginNav")
                
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = loginViewController
                self.window = window
                window.makeKeyAndVisible()
                window.overrideUserInterfaceStyle = .light
            }
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("will back", timerTime += 1)
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("will front", timerTime)

        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

