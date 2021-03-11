//
//  TimerViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/06.
//

import UIKit

class TimerViewController: UIViewController {
    var isReading: Bool = true
    var readingTime : Int = 0

    @IBOutlet weak var timerBackgroundView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var targetRadingTimeLabel: UILabel!
    @IBOutlet weak var pauseRadingButton: UIButton!
    @IBOutlet weak var stopReadingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

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
        
        pauseRadingButton.contentEdgeInsets = UIEdgeInsets(top: 11, left: 20, bottom: 15, right: 20)
        pauseRadingButton.setTitleColor(.main, for: .normal)
        pauseRadingButton.backgroundColor = .none
        pauseRadingButton.layer.borderWidth = 1
        pauseRadingButton.layer.borderColor = UIColor.main.cgColor
        pauseRadingButton.layer.cornerRadius = 24
        
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
    
    @objc func skipTimeRecoding(sender: UIBarButtonItem) {
        print("LOG - Timer Skip Button is Clicked")
    }

    @objc func popViewController(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        print("LOG - Back to Main from Timer View Controller")
    }
    
    @IBAction func pauseTimer(_ sender: UIButton) {
        changeReadingStatus()
    }
    
    @IBAction func stopTimer(_ sender: UIButton) {
        let dailyReadingCompletionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dailyReadingCompletionVC") as! DailyReadingCompletionViewController
        self.navigationController?.pushViewController(dailyReadingCompletionVC, animated: true)
    }
    
    private func changeReadingStatus() {
        // 읽기 여부, 읽은 시간 저장, 읽기 버튼 UI변경
        if isReading == true {
            pauseRadingButton.setImage(UIImage(named: "playicon"), for: .normal)
            pauseRadingButton.setTitle(" 계속 읽기", for: .normal)
            isReading = false
        } else {
            pauseRadingButton.setImage(UIImage(named: "pauseIcon"), for: .normal)
            pauseRadingButton.setTitle(" 잠시 멈춤", for: .normal)
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
