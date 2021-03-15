//
//  DailyReadingCompletionViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/07.
//

import UIKit

class DailyReadingWrittenViewController: UIViewController {
    
    @IBOutlet weak var readingTargetTimeLabel: UILabel!
    @IBOutlet weak var daillyTotalReadingTimeLabel: UILabel!

    // 로직 없이 UI 셋업만 하는 컴포넌트
    @IBOutlet weak var daillyRadingTitleLabel: UILabel!
    @IBOutlet weak var daillyRadingSubTitleLabel: UILabel!
    @IBOutlet weak var WriteDiaryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setNavBar()
        WriteDiaryButton.makeRoundedButtnon("일지 작성하기", titleColor: .main, borderColor: UIColor.main.cgColor, backgroundColor: .white)

        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "timer")
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 목표 00분" ))
        readingTargetTimeLabel.attributedText = attributedString
        readingTargetTimeLabel.textColor = .middlegrey1
        
        daillyRadingTitleLabel.textColor = .charcoal
        daillyTotalReadingTimeLabel.textColor = .main
        let attributedTimeString = NSMutableAttributedString()
            .normal("총", fontSize: 25)
            .bold("00", fontSize: 25)
            .normal("분", fontSize: 25)
            .bold("00", fontSize: 25)
            .normal("초", fontSize: 25)
        daillyTotalReadingTimeLabel.attributedText = attributedTimeString
        daillyRadingSubTitleLabel.textColor = .darkgrey
    }
    
    private func setNavBar() {
        let rightButton = UIBarButtonItem(image: UIImage(named: "shareIconLine"), style: .plain, target: self, action: #selector(shareDaillyReadingResult(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .darkgrey
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }
    
    @objc func shareDaillyReadingResult(sender: UIBarButtonItem) {
        let timerStopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timerStopVC") as! TimerStopViewController
        self.navigationController?.pushViewController(timerStopVC, animated: true)
    }
    
    @IBAction func writeDaillyReadingDiary(_ sender: UIButton) {
        let writeDiaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writeDiaryVC") as! DaillyReadingWritenViewController
        self.navigationController?.pushViewController(writeDiaryVC, animated: true)
    }
    
}
