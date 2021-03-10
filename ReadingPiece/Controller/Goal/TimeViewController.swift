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
    @IBOutlet weak var minuteLabel: UILabel!
    
    let datePicker = UIDatePicker()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    func createDatePicker() {
        minuteLabel.isHidden = true
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor.lightgrey1
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        doneButton.tintColor = .melon
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let timeLabel = UILabel(frame: .zero)
        timeLabel.text = "매일 독서 시간"
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.NotoSans(.regular, size: 14)
        timeLabel.textColor = #colorLiteral(red: 0.2274509804, green: 0.231372549, blue: 0.2392156863, alpha: 1)
        let textBarButton = UIBarButtonItem(customView: timeLabel)
        toolbar.setItems([flexibleSpace, textBarButton, flexibleSpace, doneButton], animated: true)
        
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = datePicker
        datePicker.datePickerMode = .countDownTimer
        
    }
    
    @objc func donePressed() {
        timeTextField.text = "\(Int(datePicker.countDownDuration/60))"
        minuteLabel.isHidden = false
        self.view.endEditing(true)
    }
    
    @IBAction func timeSelectButtonTapped(_ sender: Any) {
        timeTextField.becomeFirstResponder()
    }
    
}
