//
//  LoginViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/28.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var IDCancelButton: UIButton!
    @IBOutlet weak var passwordCancelButton: UIButton!
    
    var isIDEditing : Bool = false
    var isPWEditing : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IDTextField.delegate = self
        passwordTextField.delegate = self
        IDTextField.font = .NotoSans(.regular, size: 14)
        passwordTextField.font = .NotoSans(.regular, size: 14)
        loginButton.makeRoundedButtnon("로그인", titleColor: #colorLiteral(red: 0.7097406387, green: 0.7098445296, blue: 0.7097179294, alpha: 1) , borderColor: #colorLiteral(red: 0.8548267484, green: 0.8549502492, blue: 0.8547996879, alpha: 1), backgroundColor: #colorLiteral(red: 0.8548267484, green: 0.8549502492, blue: 0.8547996879, alpha: 1))
        loginButton.titleLabel?.font = .NotoSans(.medium, size: 16)
        loginButton.isEnabled = false
        
        self.dismissKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func IDCancelButtonTapped(_ sender: Any) {
        IDTextField.text = ""
    }
    
    @IBAction func PWCancelButtonTapped(_ sender: Any) {
        passwordTextField.text = ""
    }
    
    @IBAction func tapBackground(_ sender: Any) {
        if isIDEditing {
            IDTextField.resignFirstResponder()
        }else if isPWEditing {
            passwordTextField.resignFirstResponder()
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.showIndicator()
        Network.request(req: LoginRequest(email: self.IDTextField.text!, password: self.passwordTextField.text!)) { [self] result in
            switch result {
            case .success(let response):
                self.dismissIndicator()
                let result = response.code
                if result == 1000 {
                    print("로그인 성공")
                    let ud = UserDefaults.standard
                    ud.setValue(response.jwt, forKey: "jwtToken") // 삭제 예정
                    ud.setValue(true, forKey: "loginConnected") // 삭제 예정
                    
                    // 키체인에 토큰 등록
                    guard let token = response.jwt else { return }
                    if keychain.set(token, forKey: Keys.token, withAccess: KeychainSwiftAccessOptions.accessibleAfterFirstUnlock) {
                        print("Keychain setting success.")
                    } else {
                        print("Failed to set on Keychain")
                    }
                    let vc = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "TermViewController") as! TermViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.presentAlert(title: response.message, isCancelActionIncluded: false) {_ in
                        self.IDTextField.text = ""
                        self.passwordTextField.text = ""
                    }
                }
            case .cancel(let cancelError):
                self.dismissIndicator()
                print(cancelError as Any)
            case .failure(let error):
                self.dismissIndicator()
                print(error as Any)
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false) {_ in
                    // 서버 불안정할 시 테스트용 (삭제 예정)
                    let vc = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "TermViewController") as! TermViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: Any) {
        let popupVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "PasswordResetViewController") as! PasswordResetViewController
        popupVC.modalPresentationStyle = .overCurrentContext
        self.present(popupVC, animated: true, completion: nil)
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == IDTextField {
            passwordTextField.becomeFirstResponder()
        }else{
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if IDTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
            loginButton.makeRoundedButtnon("로그인", titleColor: .white, borderColor: UIColor.melon.cgColor, backgroundColor: .melon)
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
        
    }
}
