//
//  LoginSplashViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/18.
//

import UIKit
import KeychainSwift
import AuthenticationServices

class LoginSplashViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: Any) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    

}

// 애플 소셜로그인 관련 Delegate
extension LoginSplashViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
               let authString = String(data: authorizationCode, encoding: .utf8),
               let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
                
                // 키체인에 토큰 저장
                if keychain.set(tokenString, forKey: Keys.token, withAccess: KeychainSwiftAccessOptions.accessibleAfterFirstUnlock) {
                    print("Keychain setting success.")
                    let vc = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "GoalNavController") as! GoalNavViewController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
            
            print("userIdentifier: \(userIdentifier), fullName: \(String(describing: fullName)), email: \(email ?? "no data")")
            
            // 키체인에 userIdentifier 저장
            let identifier = userIdentifier
            if keychain.set(identifier, forKey: Keys.userIdentifier, withAccess: KeychainSwiftAccessOptions.accessibleAfterFirstUnlock) {
                print("Keychain setting success.")
            } else {
                print("Failed to set on Keychain")
            }
        
            // 회원가입 여부 검사한 뒤
            // 회원이 아니면 회원가입
            // 회원이면 로그인 진행
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username), password: \(password)")
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.presentAlert(title: "애플 계정 연동에 실패하였습니다. ")
    }
    
}
