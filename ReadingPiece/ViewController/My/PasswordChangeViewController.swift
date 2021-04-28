//
//  PasswordChangeViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import UIKit
import KeychainSwift

class PasswordChangeViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    // 비밀번호 형식
    let validityType: String.ValidityType = .password
    
    // 완료 버튼 활성화 여부 체크
    var resetActivated: Bool = false {
        didSet {
            if resetActivated == true {
                editCompleteButton.isEnabled = true
                editCompleteButton.tintColor = .melon
            } else {
                editCompleteButton.isEnabled = false
                editCompleteButton.tintColor = .grey
            }
        }
    }
    
    @IBOutlet weak var editCancelButton: UIBarButtonItem!
    @IBOutlet weak var editCompleteButton: UIBarButtonItem!
    
    @IBOutlet weak var originPasswordTextField: UITextField!
    @IBOutlet weak var originPasswordRemoveButton: UIButton!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordRemoveButton: UIButton!
    @IBOutlet weak var pwStyleCheckLabel: UILabel!
    
    
    @IBOutlet weak var checkNewPasswordTextField: UITextField!
    @IBOutlet weak var checkNewPasswordRemoveButton: UIButton!
    @IBOutlet weak var pwConfirmLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        checkNewPasswordTextField.delegate = self
        
        pwStyleCheckLabel.isHidden = true
        pwConfirmLabel.isHidden = true
        
        resetActivated = false
        self.dismissKeyboardWhenTappedAround()
    }
    
    // 텍스트필트 캔슬 버튼
    @IBAction func originPasswordRemoveButtonTapped(_ sender: Any) {
        originPasswordTextField.text = ""
        resetActivated = false
    }
    @IBAction func newPasswordRemoveButtonTapped(_ sender: Any) {
        newPasswordTextField.text = ""
        resetActivated = false
    }
    @IBAction func checkNewPasswordRemoveButtonTapped(_ sender: Any) {
        checkNewPasswordTextField.text = ""
        resetActivated = false
    }
    
    // 텍스트필드 변경 실시간 감지 - 비밀번호 형식 체크
    @IBAction func newPasswordEditingChanged(_ sender: Any) {
        if let text = newPasswordTextField.text {
            if text.isValid(validityType) {
                pwStyleCheckLabel.isHidden = true
            } else {
                pwStyleCheckLabel.isHidden = false
                pwStyleCheckLabel.text = "영문/숫자 6~20자리를 입력해주세요. "
            }
        }
    }
    
    // 텍스트필드 변경 실시간 감지 - 비밀번호 일치여부 검사
    @IBAction func checkNewPasswordEditingChanged(_ sender: UITextField) {
        if sender.text != self.newPasswordTextField.text {
            pwConfirmLabel.isHidden = false
            pwConfirmLabel.text = "비밀번호가 일치하지 않습니다. "
            resetActivated = false
        } else {
            pwConfirmLabel.isHidden = true
            print("password confirmed")
        }
    }
    
    
    // 비밀번호 변경 취소, 완료 버튼
    @IBAction func editCancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editCompleteButtonTapped(_ sender: Any) {
        resetPassword()
    }
    
    private func resetPassword() {
        print("비밀번호 변경 진행중")
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: PasswordResetRequest(token: token, presentPW: originPasswordTextField.text!, password: checkNewPasswordTextField.text!)) { result in
            switch result {
            case .success(let response):
                print(response)
                if response.code == 1000 {
                    self.presentAlert(title: "비밀번호 변경에 성공하였습니다. ", isCancelActionIncluded: false) {_ in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                } else {
                    let message = response.message
                    self.presentAlert(title: message, isCancelActionIncluded: false)
                }
            case .cancel, .failure:
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다. ", isCancelActionIncluded: false)
            }
        }
    }

}

extension PasswordChangeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == originPasswordTextField {
            newPasswordTextField.becomeFirstResponder()
        } else if textField == newPasswordTextField {
            checkNewPasswordTextField.becomeFirstResponder()
        } else {
            checkNewPasswordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if originPasswordTextField.text?.isEmpty == false && newPasswordTextField.text?.isEmpty == false && checkNewPasswordTextField.text?.isEmpty == false {
            if pwStyleCheckLabel.isHidden == true && pwConfirmLabel.isHidden == true {
                resetActivated = true
            } else {
                resetActivated = false
            }
        } else {
            resetActivated = false
        }
    }
}
