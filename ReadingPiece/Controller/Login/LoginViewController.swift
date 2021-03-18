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
        self.IDTextField.font = .NotoSans(.regular, size: 14)
        self.passwordTextField.font = .NotoSans(.regular, size: 14)
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
}
