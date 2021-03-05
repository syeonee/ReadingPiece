//
//  TimeViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/05.
//

import UIKit

class TimeViewController: UIViewController {

    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var timeSelectButton: UIButton!
    @IBOutlet weak var arrowButton: UIButton!
    
    let datePicker = UIDatePicker()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = datePicker
        datePicker.datePickerMode = .countDownTimer
        
    }
    
    @objc func donePressed() {
        timeTextField.text = "\(Int(datePicker.countDownDuration/60))"
        self.view.endEditing(true)
    }
    
    @IBAction func timeSelectButtonTapped(_ sender: Any) {
        timeTextField.becomeFirstResponder()
        
    }
    
}
