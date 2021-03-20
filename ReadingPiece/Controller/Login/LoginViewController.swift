//
//  LoginViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/28.
//

import UIKit

class LoginViewController: UIViewController {
    
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
        Network.request(req: LoginRequest(email: self.IDTextField.text!, password: self.passwordTextField.text!)) { result in
            switch result {
            case .success(let response):
                let result = response.code
                if result == 1000 {
                    print("로그인 성공")
                    let ud = UserDefaults.standard
                    ud.setValue(response.jwt, forKey: "jwtToken")
                    ud.setValue(true, forKey: "loginConnected")
                    let vc = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "TermViewController") as! TermViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.presentAlert(title: response.message, isCancelActionIncluded: false) {_ in
                        self.IDTextField.text = ""
                        self.passwordTextField.text = ""
                    }
                }
            case .cancel(let cancelError):
                print(cancelError as Any)
            case .failure(let error):
                print(error as Any)
                self.presentAlert(title: "로그인에 실패하였습니다. ", isCancelActionIncluded: false)
            }
        }
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
