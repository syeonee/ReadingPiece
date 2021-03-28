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
    var amount: Int = 0

    @IBOutlet weak var readingTimeLabel: UILabel!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var timeSelectButton: UIButton!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var addGoalButton: UIButton!
    let usderDefaults = UserDefaults.standard
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    @objc func donePressed() {
        let minute = Int(datePicker.countDownDuration/60)
        time = minute
        timeTextField.text = "\(minute)"
        minuteLabel.isHidden = false
        readingTimeLabel.text = """
                                    매일  \(minute) 분
                                    책을 읽을 거에요
                                """
        addGoalButton.setImage(UIImage(named: "selectedNext"), for: .normal)
        self.view.endEditing(true)
    }
    
    @IBAction func timeSelectButtonTapped(_ sender: Any) {
        timeTextField.becomeFirstResponder()
    }
    
    @IBAction func addGoalAction(_ sender: UIButton) {
        setReadingGoal()
    }
    
    func initTerm(readingPeriod: String, readingAmount: Int) {
        period = readingPeriod
        amount = readingAmount
    }
    
    // 전달받은 Goal 값을 이용해 목표 설정
    func setReadingGoal() {
        if amount != 0 && period != "" && time != 0 {
            postUserReadingGoal()
        }
    }
    
    func postUserReadingGoal() {
        let req = PostReadingGoalRequest(Goal(period: period, amount: amount, time: time))
                                
        _ = Network.request(req: req) { (result) in
                
                switch result {
                case .success(let userResponse):
                    print("LOG - 목표설정 완료", self.amount, self.period, self.time, userResponse.message, userResponse.goalId)
                    guard let searchVC = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(withIdentifier: "searchBookViewController") as? SearchBookViewController else { return }
                    self.usderDefaults.set(userResponse.goalId, forKey: Constants().USERDEFAULT_KEY_GOAL_ID)
                    self.navigationController?.pushViewController(searchVC, animated: true)
                case .cancel(let cancelError):
                    print(cancelError!)
                case .failure(let error):
                    self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false)
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
}
