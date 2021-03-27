//
//  TimerViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/06.
//

import UIKit

class TimerViewController: UIViewController {
    let defaults = UserDefaults.standard
    var isReading: Bool = true
    var readingTime : Int = 0
    var challengeInfo : ChallengerInfo?
    
    @IBOutlet weak var timerBackgroundView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var targetRadingTimeLabel: UILabel!
    @IBOutlet weak var stopReadingButton: UIButton!
    @IBOutlet weak var startPauseRadingButton: UIButton!
    private lazy var stopwatch = Stopwatch(timeUpdated: { timeInterval in
        self.defaults.setValue(Int(timeInterval), forKey: Constants().USERDEFAULT_KEY_CURRENT_TIMER_TIME)
        self.currentTimeLabel.text = self.timeString(from: timeInterval)
    })
    
    deinit {
        stopwatch.stop()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopwatch.toggle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = "시간 기록"
    }

    
    @objc func skipTimeRecoding(sender: UIBarButtonItem) {
        // 목표시간 미달 안내 씬으로 이동
        stopwatch.stop()
        startPauseRadingButton.isSelected = false
        let dailyReadingCompletionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timerStopVC") as! TimerStopViewController
        self.navigationController?.pushViewController(dailyReadingCompletionVC, animated: true)
    }

    @objc func popViewController(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pauseTimer(_ sender: UIButton) {
        changeReadingStatus()
        sender.isSelected = !sender.isSelected
        stopwatch.toggle()
    }
    
    @IBAction func stopTimer(_ sender: UIButton) {
        stopwatch.stop()
        startPauseRadingButton.isSelected = false
        let dailyReadingCompletionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dailyReadingCompletionVC") as! DailyGoalCompletionViewController
        let savedTime = defaults.integer(forKey: Constants().USERDEFAULT_KEY_CURRENT_TIMER_TIME) 
        print("LOG TIME", savedTime)
        self.navigationController?.pushViewController(dailyReadingCompletionVC, animated: true)
    }

    private func setupUI() {
        setNavBar()
        timerBackgroundView.layer.borderWidth = 5
        timerBackgroundView.layer.borderColor = UIColor.sub2.cgColor
        timerBackgroundView.makeCircle()
        currentTimeLabel.textColor = .charcoal
        bookTitleLabel.textColor = .black
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "timer")
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 목표 20분" ))
        targetRadingTimeLabel.attributedText = attributedString
        targetRadingTimeLabel.textColor = .darkgrey
        
        startPauseRadingButton.contentEdgeInsets = UIEdgeInsets(top: 11, left: 20, bottom: 15, right: 20)
        startPauseRadingButton.setTitleColor(.main, for: .normal)
        startPauseRadingButton.backgroundColor = .none
        startPauseRadingButton.layer.borderWidth = 1
        startPauseRadingButton.layer.borderColor = UIColor.main.cgColor
        startPauseRadingButton.layer.cornerRadius = 24
        
        stopReadingButton.contentEdgeInsets = UIEdgeInsets(top: 11, left: 20, bottom: 15, right: 20)
        stopReadingButton.setTitleColor(.white, for: .normal)
        stopReadingButton.layer.borderWidth = 1
        stopReadingButton.layer.borderColor = UIColor.main.cgColor
        stopReadingButton.backgroundColor = .main
        stopReadingButton.layer.cornerRadius = 24
    }
    
    private func setNavBar() {
        // extension으로 타이틀, 왼쪽 이름 없애기, 오른쪽 버튼 생성
        self.navigationItem.title = "시간 기록"
        self.navigationController?.navigationBar.topItem?.title = ""
        let rightButton = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(skipTimeRecoding(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .main
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }
    
    func timeString(from timeInterval: TimeInterval) -> String {
        // 추후 재사용을 위해 타이머 시간은 초 단위로 유저디폴트에 저장
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
        let hours = Int(timeInterval / 3600)
        return String(format: "%.2d:%.2d:%.2d", hours, minutes, seconds)
    }

    private func changeReadingStatus() {
        // 읽기 여부, 읽은 시간 저장, 읽기 버튼 UI변경
        if isReading == true {
            startPauseRadingButton.setImage(UIImage(named: "playicon"), for: .normal)
            startPauseRadingButton.setTitle(" 계속 읽기", for: .normal)
            isReading = false
        } else {
            startPauseRadingButton.setImage(UIImage(named: "pauseIcon"), for: .normal)
            startPauseRadingButton.setTitle(" 잠시 멈춤", for: .normal)
            isReading = true
        }
    }
    
}

extension UIView {
    func makeCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
