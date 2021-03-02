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
    
    @IBOutlet weak var IDUnderBar: UIView!
    @IBOutlet weak var passwordUnderBar: UIView!
    
    @IBOutlet weak var IDImageView: UIImageView!
    @IBOutlet weak var passwordImageView: UIImageView!
    
    @IBOutlet weak var IDCancelButton: UIButton!
    @IBOutlet weak var passwordCancelButton: UIButton!
    
    var isIDEditing : Bool = false
    var isPWEditing : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IDTextField.delegate = self
        passwordTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
}

extension LoginViewController {
    @objc private func keyboardWillShow(noti: Notification) {
        let loginButtonBottomY = loginButton.frame.origin.y + loginButton.frame.size.height
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let keyboardToButtonDistance = loginButtonBottomY - keyboardFrame.origin.y + view.safeAreaInsets.bottom
        self.view.frame.origin.y = -(keyboardToButtonDistance + 10)
        
    }
    
    @objc private func keyboardWillHide(noti: Notification) {
        self.view.frame.origin.y = 0
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == IDTextField {
            isIDEditing = true
            IDImageView.image = UIImage(named: "editId.png")
            IDTextField.textColor = #colorLiteral(red: 1, green: 0.4235294118, blue: 0.3725490196, alpha: 1)
            IDUnderBar.backgroundColor = #colorLiteral(red: 1, green: 0.4235294118, blue: 0.3725490196, alpha: 1)
        }else{
            isPWEditing = true
            passwordImageView.image = UIImage(named: "editPW.png")
            passwordTextField.textColor = #colorLiteral(red: 1, green: 0.4235294118, blue: 0.3725490196, alpha: 1)
            passwordUnderBar.backgroundColor = #colorLiteral(red: 1, green: 0.4235294118, blue: 0.3725490196, alpha: 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == IDTextField {
            isIDEditing = false
            IDImageView.image = UIImage(named: "id.png")
            IDTextField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            IDUnderBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            isPWEditing = false
            passwordImageView.image = UIImage(named: "pw.png")
            passwordTextField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            passwordUnderBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
