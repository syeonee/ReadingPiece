//
//  InputReadingStatusPopupViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/12.
//

import UIKit

// 읽은 페이지수를 입력받는 화면
class InputReadingStatusPopupViewController: UIViewController {
    
    static var storyobardId: String = "InputReadingStatusPopupVC"
    var readingStatusDelegate: ReadingStatusDelegate?
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var closePopupButton: UIButton!
    @IBOutlet weak var popupTitleLabel: UILabel!
    @IBOutlet weak var popupSubtitleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        view.isOpaque = false
        popupView.layer.cornerRadius = 14
        inputTextField.layer.borderColor = UIColor.lightgrey2.cgColor
        inputTextField.keyboardType = .numberPad
        inputTextField.textColor = .black
        inputTextField.backgroundColor = .lightgrey2
        closePopupButton.tintColor = .darkgrey
        doneButton.makeRoundedButtnon("완료", titleColor: .darkgrey, borderColor: UIColor.middlegrey2.cgColor, backgroundColor: .middlegrey2)
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePopup(_ sender: UIButton) {
        if let text = inputTextField.text{
            if text.count < 4 {
                readingStatusDelegate?.setReadingPage(Int(text) ?? 0)
                self.dismiss(animated: true, completion: nil)
            } else {
                view.makeToast("입력 범위는 1000을 초과할 수 없습니다.", duration: 2, position: .center)
            }
        }
    }
    
}

extension InputReadingStatusPopupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else {return false}
        if text != nil  {
                doneButton.makeRoundedButtnon("완료", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
            } else {
                doneButton.makeRoundedButtnon("완료", titleColor: .darkgrey, borderColor: UIColor.middlegrey2.cgColor, backgroundColor: .middlegrey2)
            }
        
            return true
        }
}
