//
//  PasswordResetViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/21.
//

import UIKit

class PasswordResetViewController: UIViewController {
    
    var submitActivated: Bool = false {
        didSet {
            if submitActivated == true {
                submitButton.isEnabled = true
                submitButton.makeRoundedButtnon("전송하기", titleColor: .white, borderColor: UIColor.melon.cgColor, backgroundColor: .melon)
            } else {
                submitButton.isEnabled = false
                submitButton.makeRoundedButtnon("전송하기", titleColor: .melon, borderColor: UIColor.melon.cgColor, backgroundColor: .white)
            }
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var emailInputTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        emailInputTextField.delegate = self
        self.dismissKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    func setUI(){
        
        popupView.layer.cornerRadius = 10
        titleLabel.text = "비밀번호 재설정"
        titleLabel.font = .NotoSans(.bold, size: 18)
        descLabel.text = "가입하신 이메일을 입력해주세요. \n비밀번호 재설정 메일이 발송됩니다."
        descLabel.font = .NotoSans(.regular, size: 13)
        emailInputTextField.layer.cornerRadius = 8
        emailInputTextField.font = .NotoSans(.regular, size: 16)
        //submitButton.makeRoundedButtnon("전송하기", titleColor: .melon, borderColor: UIColor.melon.cgColor, backgroundColor: .white)
        submitActivated = false
        submitButton.titleLabel?.font = .NotoSans(.medium, size: 16)
        
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        // api 호출하기
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PasswordResetViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailInputTextField.resignFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailInputTextField.text?.isEmpty == false {
            submitActivated = true
        } else {
            submitActivated = false
        }
    }
}
