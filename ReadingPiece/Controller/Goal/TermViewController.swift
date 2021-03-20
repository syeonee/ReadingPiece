//
//  TermViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/02.
//

import UIKit

class TermViewController: UIViewController {
    var period: String?
    var amount: Int?
    
    @IBOutlet weak var bookQuantityTextField: UITextField!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        createToolbar()
        initButtonTag()
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor.lightgrey1
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        doneButton.tintColor = .melon
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        bookQuantityTextField.inputAccessoryView = toolbar
    }
    
    func initButtonTag() {
        weekButton.tag = 1
        monthButton.tag = 2
        yearButton.tag = 3
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
        amount = Int(bookQuantityTextField.text ?? "0")
    }
    
    @IBAction func termButtonTapped(_ sender: UIButton) {
        let buttons = [weekButton,monthButton,yearButton]

        buttons.forEach{ (button) in
            if button == sender {
                button?.isSelected = true
                guard let btnTag =  button?.tag else { return }
                setReadingTermByBtnClicked(tag: btnTag)
            }else {
                button?.isSelected = false
            }
        }
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if let readingAmount = amount, let readingPeriod = period {
            let TimeVC = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(withIdentifier: "TimeViewController") as! TimeViewController
            self.navigationController?.pushViewController(TimeVC, animated: true)
        }
    }
    
    func setReadingTermByBtnClicked(tag: Int) {
        switch tag {
        case 1:
            period = "W"
        case 2:
            period = "M"
        case 3:
            period = "D"
        default:
            period = nil
        }
    }
}
