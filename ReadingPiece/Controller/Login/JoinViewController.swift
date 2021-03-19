//
//  JoinViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/18.
//

import UIKit

class JoinViewController: UIViewController {
    
    var saveID: Bool = false {
        didSet {
            if saveID == true {
                saveIDButton.setImage(UIImage(named: "checkedID"), for: .normal) // 이미지 받아서 배경 있는걸로 바꿔놓기
            } else {
                saveIDButton.setImage(UIImage(named: "uncheckedIdGrey"), for: .normal)
            }
        }
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pwConfirmTextField: UITextField!
    
    @IBOutlet weak var saveIDButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        pwConfirmTextField.delegate = self
        
        emailTextField.font = .NotoSans(.regular, size: 14)
        emailTextField.textColor = .black
        passwordTextField.font = .NotoSans(.regular, size: 14)
        passwordTextField.textColor = .black
        pwConfirmTextField.font = .NotoSans(.regular, size: 14)
        pwConfirmTextField.textColor = .black
        
        joinButton.makeRoundedButtnon("가입 완료", titleColor: .grey, borderColor: UIColor.fillDisabled.cgColor, backgroundColor: .fillDisabled)
        joinButton.isEnabled = false
    }
    
    @IBAction func emailCancel(_ sender: Any) {
        emailTextField.text  = ""
    }
    @IBAction func pwCancel(_ sender: Any) {
        passwordTextField.text = ""
    }
    @IBAction func pwConfifmCancel(_ sender: Any) {
        pwConfirmTextField.text = ""
    }
    
    @IBAction func saveIDButtonTapped(_ sender: Any) {
        if saveID == true {
            saveID = false
        } else {
            saveID = true
        }
    }
    
    
    @IBAction func joinComplete(_ sender: Any) {
        Network.request(req: JoinRequest(email: self.emailTextField.text!, password: self.pwConfirmTextField.text!)) { result in
            switch result {
            case .success(let response):
                print(response)
                self.navigationController?.popViewController(animated: true)
            case .cancel(let cancelError):
                print(cancelError as Any)
            case .failure(let error):
                print(error as Any)
                
            }
        }
    }
    
    @IBAction func pwConfirmEditingChanged(_ sender: UITextField) {
        if sender.text != self.passwordTextField.text {
            print(sender.text ?? "")
        } else {
            print("password confirmed")
        }
        
    }
    
    
    
}

// TextField Delegate
extension JoinViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            pwConfirmTextField.becomeFirstResponder()
        } else {
            pwConfirmTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false && pwConfirmTextField.text?.isEmpty == false {
            joinButton.isEnabled = true
            joinButton.makeRoundedButtnon("가입 완료", titleColor: .white, borderColor: UIColor.melon.cgColor, backgroundColor: .melon)
        } else {
            joinButton.isEnabled = false
        }
        
    }
    
    
}
