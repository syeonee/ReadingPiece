//
//  DailyReadingCompletionViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/07.
//

import UIKit

class DailyGoalCompletionViewController: UIViewController {
    let userName = UserDefaults.standard.string(forKey: Constants.USERDEFAULT_KEY_GOAL_USER_NAME)
    let goalBookId = UserDefaults.standard.string(forKey: Constants.USERDEFAULT_KEY_GOAL_BOOK_ID)
    let goalId = UserDefaults.standard.string(forKey: Constants.USERDEFAULT_KEY_GOAL_ID)
    var time: Int = 0
//    let challengeId = UserDefaults.standard.string(forKey: Constants.USERDEFAULT_KEY_GOAL_USER_NAME)
    
    @IBOutlet weak var DailyGoalResultView: UIView!
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
        shareResult()
    }
    
    func shareResult() {
        let image = DailyGoalResultView.captureScreenToImage()
        let waterMardkedImage = addWaterMark(image: image!)
        let imageToShare = [ waterMardkedImage ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func addWaterMark(image: UIImage) -> UIImage {
            let backgroundImage = image//UII
            let watermarkImage = UIImage(named: "waterMark.png")

            UIGraphicsBeginImageContextWithOptions(backgroundImage.size, false, 0.0)
            backgroundImage.draw(in: CGRect(x: 0.0, y: 0.0, width: backgroundImage.size.width, height: backgroundImage.size.height))
            watermarkImage!.draw(in: CGRect(x: backgroundImage.size.width - watermarkImage!.size.width, y: 0, width: watermarkImage!.size.width, height: watermarkImage!.size.height))
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result!
        }
    
    @IBAction func writeDaillyReadingDiary(_ sender: UIButton) {
        if userName != "Reader" {
            let writeDiaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writeDiaryVC") as! DaillyReadingWritenViewController
            self.navigationController?.pushViewController(writeDiaryVC, animated: true)
        } else {
            self.presentAlert(title: "MY페이지에서 닉네임을 먼저 설정해주세요.", isCancelActionIncluded: false)
        }
    }
    
}
