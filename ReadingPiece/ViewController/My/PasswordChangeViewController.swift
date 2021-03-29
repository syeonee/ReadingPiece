//
//  PasswordChangeViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    
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
    
    @IBOutlet weak var checkNewPasswordTextField: UITextField!
    @IBOutlet weak var checkNewPasswordRemoveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        checkNewPasswordTextField.delegate = self
        
        resetActivated = false
        // Do any additional setup after loading the view.
    }
    @IBAction func editCancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editCompleteButtonTapped(_ sender: Any) {
        resetPassword()
    }
    
    private func resetPassword() {
        print("비밀번호 변경 진행중")
        Network.request(req: PasswordResetRequest(password: checkNewPasswordTextField.text!)) { result in
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
            case .cancel(let cancel):
                print(cancel as Any)
            case .failure(let error):
                print(error?.localizedDescription as Any)
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
            resetActivated = true
        } else {
            resetActivated = false
        }
    }
}
