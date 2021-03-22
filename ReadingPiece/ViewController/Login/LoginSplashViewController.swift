//
//  LoginSplashViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/18.
//

import UIKit
import AuthenticationServices

class LoginSplashViewController: UIViewController {

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            
            print("userIdentifier: \(userIdentifier), fullName: \(String(describing: fullName)), email: \(email ?? "no data")")
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            //self.saveUserInKeychain(userIdentifier)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            //self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username), password: \(password)")
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                //self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
}
