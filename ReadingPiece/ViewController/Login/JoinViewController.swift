//
//  JoinViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/18.
//

import UIKit
import KeychainSwift

class JoinViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    // 자동로그인 여부 체크
    var saveID: Bool = false {
        didSet {
            if saveID == true {
                saveIDButton.setImage(UIImage(named: "checkedID"), for: .normal) // 이미지 받아서 배경 있는걸로 바꿔놓기
            } else {
                saveIDButton.setImage(UIImage(named: "uncheckedIdGrey"), for: .normal)
            }
        }
    }
    
    // 가입 완료 버튼 활성화여부 체크
    var joinActivated: Bool = false {
        didSet {
            if joinActivated == true {
                joinButton.isEnabled = true
                joinButton.makeRoundedButtnon("가입 완료", titleColor: .white, borderColor: UIColor.melon.cgColor, backgroundColor: .melon)
            } else {
                joinButton.isEnabled = false
                joinButton.makeRoundedButtnon("가입 완료", titleColor: .grey, borderColor: UIColor.fillDisabled.cgColor, backgroundColor: .fillDisabled)
            }
        }
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pwConfirmTextField: UITextField!
    @IBOutlet weak var pwConfirmLabel: UILabel!
    
    
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var pwImageView: UIImageView!
    @IBOutlet weak var pwConfirmImageView: UIImageView!
    
    
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
        pwConfirmLabel.font = .NotoSans(.regular, size: 12)
        pwConfirmLabel.textColor = .red
        pwConfirmLabel.isHidden = true
        
        joinButton.makeRoundedButtnon("가입 완료", titleColor: .grey, borderColor: UIColor.fillDisabled.cgColor, backgroundColor: .fillDisabled)
        joinButton.isEnabled = false
        
        self.dismissKeyboardWhenTappedAround()
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
                let result = response.code
                if result == 1000 {
                    self.presentAlert(title: "회원가입에 성공하였습니다. ", isCancelActionIncluded: false, handler: { [self]_ in
                        // jwt 토큰 저장한 뒤 책추가 화면으로 이동
                        let ud = UserDefaults.standard
                        ud.setValue(response.jwt, forKey: "jwtToken")
                        ud.setValue(true, forKey: "loginConnected")
                        
                        // 키체인에 토큰 등록
                        guard let token = response.jwt else { return }
                        if keychain.set(token, forKey: Keys.token, withAccess: KeychainSwiftAccessOptions.accessibleAfterFirstUnlock) {
                            print("Keychain setting success.")
                        } else {
                            print("Failed to set on Keychain")
                        }
                        let vc = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "TermViewController") as! TermViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                } else if result == 2001 && result == 2002 {  // 이메일 입력 관련 오류
                    self.presentAlert(title: response.message, isCancelActionIncluded: false) {_ in
                        self.emailTextField.text = ""
                    }
                } else if result == 2003 && result == 2004 {  // 비밀번호 입력 관련 오류
                    self.presentAlert(title: response.message, isCancelActionIncluded: false) {_ in
                        self.passwordTextField.text = ""
                        self.pwConfirmTextField.text = ""
                    }
                } else { // 중복된 이메일인 경우
                    self.presentAlert(title: response.message, isCancelActionIncluded: false, handler: {_ in
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                        self.pwConfirmTextField.text = ""
                    })
                }
            case .cancel(let cancelError):
                print(cancelError as Any)
            case .failure(let error):
                print(error as Any)
                self.presentAlert(title: "회원가입에 실패하였습니다. ", isCancelActionIncluded: false) 
            }
        }
    }
    
    // 비밀번호 일치여부 검사
    @IBAction func pwConfirmEditingChanged(_ sender: UITextField) {
        if sender.text != self.passwordTextField.text {
            pwConfirmLabel.isHidden = false
            pwConfirmLabel.text = "비밀번호가 일치하지 않습니다."
            joinActivated = false
        } else {
            pwConfirmLabel.isHidden = true
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailImageView.image = UIImage(named: "messageIconBlack")
            emailTextField.textColor = .black
        } else if textField == passwordTextField {
            pwImageView.image = UIImage(named: "passwordIconBlack")
            passwordTextField.textColor = .black
        } else {
            pwConfirmImageView.image = UIImage(named: "passwordIconMelon")
            pwConfirmTextField.textColor = .melon
            pwConfirmLabel.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text?.isEmpty == true {
            emailImageView.image = UIImage(named: "messageIcon")
            emailTextField.textColor = .grey
        }
        if passwordTextField.text?.isEmpty == true {
            pwImageView.image = UIImage(named: "passwordIcon")
            passwordTextField.textColor = .grey
        }
        if pwConfirmTextField.text?.isEmpty == true {
            pwConfirmImageView.image = UIImage(named: "passwordIcon2")
            pwConfirmTextField.textColor = .grey
        }
        
        if emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false && pwConfirmTextField.text?.isEmpty == false {
            joinActivated = true
        } else {
            joinActivated = false
        }
        
    }
    
    
}
