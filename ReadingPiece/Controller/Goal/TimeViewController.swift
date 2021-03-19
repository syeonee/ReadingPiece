//
//  TimeViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/05.
//

import UIKit

class TimeViewController: UIViewController {
    // Term VC에서 옵셔널 검사를 하고, 값을 넘겨줄 것 이기 때문에 편의상 논-옵셔널 변수로 생성
    var time: Int = 0
    var period: String = ""
    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var timeSelectButton: UIButton!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var minuteLabel: UILabel!
    
    let datePicker = UIDatePicker()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    // Delegate 패턴으로 전달받은 Goal 값을 이용해 목표 설정
    func setReadingGoal() {
        let req = ReadingGoalRequest(Goal(period: "D", amount: 1, time: 1))
                                
        _ = Network.request(req: req) { (result) in
                
                switch result {
                case .success(let userResponse):
                    print(userResponse)
                case .cancel(let cancelError):
                    print(cancelError!)
                case .failure(let error):
                    print(error!)
            }
        }
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
