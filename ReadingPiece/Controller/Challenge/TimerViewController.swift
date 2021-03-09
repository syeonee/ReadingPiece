//
//  TimerViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/06.
//

import UIKit

class TimerViewController: UIViewController {

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
        // extension으로 타이틀, 왼쪽 이름 없애기, 오른쪽 버튼 생성
        self.navigationItem.title = "시간 기록"
        self.navigationItem.rightBarButtonItem?.title = "건너뛰기"
        self.navigationItem.rightBarButtonItem?.tintColor = .main
        timerBackgroundView.layer.borderWidth = 5
        timerBackgroundView.layer.borderColor = UIColor.sub2.cgColor
        timerBackgroundView.makeCircle()
        currentTimeLabel.textColor = .charcoal
        bookTitleLabel.textColor = .black
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "timer")
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 목표"))
        targetRadingTimeLabel.attributedText = attributedString
        targetRadingTimeLabel.textColor = .darkgrey
        
        pauseRadingButton.contentEdgeInsets = UIEdgeInsets(top: 11, left: 20, bottom: 15, right: 20)
        pauseRadingButton.titleLabel?.textColor = .black
        pauseRadingButton.backgroundColor = .none
        pauseRadingButton.layer.borderWidth = 1
        pauseRadingButton.layer.borderColor = UIColor.main.cgColor
        pauseRadingButton.layer.cornerRadius = 24
        
        stopReadingButton.contentEdgeInsets = UIEdgeInsets(top: 11, left: 20, bottom: 15, right: 20)
        stopReadingButton.titleLabel?.textColor = .main
        stopReadingButton.layer.borderWidth = 1
        stopReadingButton.layer.borderColor = UIColor.main.cgColor
        stopReadingButton.backgroundColor = .main
        stopReadingButton.layer.cornerRadius = 24
    }
}

extension UIView {
    func makeCircle() {
        print("LOG", self.frame.width)
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
