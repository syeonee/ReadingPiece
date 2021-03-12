//
//  InputReadingStatusPopupViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/12.
//

import UIKit

class InputReadingStatusPopupViewController: UIViewController {
    @IBOutlet weak var popupView: UIView!
    static var storyobardId: String = "InputReadingStatusPopupVC"
    @IBOutlet weak var closePopupButton: UIButton!
    @IBOutlet weak var popupTitleLabel: UILabel!
    @IBOutlet weak var popupSubtitleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        view.isOpaque = false
        popupView.layer.cornerRadius = 14
        inputTextField.layer.borderColor = UIColor.lightgrey2.cgColor
        inputTextField.keyboardType = .numberPad
        inputTextField.textColor = .blue
        inputTextField.backgroundColor = .lightgrey2
        closePopupButton.tintColor = .darkgrey
        doneButton.makeRoundedButtnon("완료", titleColor: .darkgrey, borderColor: UIColor.middlegrey2.cgColor, backgroundColor: .middlegrey2)
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePopup(_ sender: UIButton) {
        
        
    }
}
