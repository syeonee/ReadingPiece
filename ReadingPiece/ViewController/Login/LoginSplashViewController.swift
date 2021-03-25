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
    
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelTap()
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
    
    // 개인정보 처리방침 웹뷰
    func setupLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.policyLabelTapped(_:)))
        self.privacyPolicyLabel.isUserInteractionEnabled = true
        self.privacyPolicyLabel.addGestureRecognizer(labelTap)
    }
    
    @objc func policyLabelTapped(_ sender: UITapGestureRecognizer) {
        let vc = PrivacyPolicyViewController()
        self.present(vc, animated: true, completion: nil)
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
            }
            
            print("userIdentifier: \(userIdentifier), fullName: \(String(describing: fullName)), email: \(email ?? "no data")")
        
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
