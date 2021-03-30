//
//  DailyReadingCompletionViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/07.
//

import UIKit

// 타이머 정지 시점에 목표 시간을 달성한 경우 나오는 화면
class DailyGoalCompletionViewController: UIViewController {
    let userName = UserDefaults.standard.string(forKey: Constants.USERDEFAULT_KEY_GOAL_USER_NAME)
    let goalBookId = UserDefaults.standard.string(forKey: Constants.USERDEFAULT_KEY_GOAL_BOOK_ID)
    let goalId = UserDefaults.standard.string(forKey: Constants.USERDEFAULT_KEY_GOAL_ID)
    let targetTime = UserDefaults.standard.integer(forKey: Constants.USERDEFAULT_KEY_GOAL_TARGET_TIME)
    var readingTime: Int = 0
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
        print("LOG - Challenge Completion VC", readingTime)
    }
    
    @objc func shareDaillyReadingResult(sender: UIBarButtonItem) {
        shareResult()
    }
    
    @IBAction func writeDaillyReadingDiary(_ sender: UIButton) {
        // 완료한 챌린지가 있으면 계속 버튼을 눌렀을때 리뷰 작성 화면으로 이동
        let writeDiaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writeDiaryVC") as! DaillyReadingWritenViewController
        writeDiaryVC.readingTime = self.readingTime
        self.navigationController?.pushViewController(writeDiaryVC, animated: true)

//        MY페이지 기능 개발 후 주석 해제 필요
//        if userName != "Reader" {
//            let writeDiaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writeDiaryVC") as! DaillyReadingWritenViewController
//            self.navigationController?.pushViewController(writeDiaryVC, animated: true)
//        } else {
//            self.presentAlert(title: "MY페이지에서 닉네임을 먼저 설정해주세요.", isCancelActionIncluded: false)
//        }
    }
    
    private func setupUI() {
        setNavBar()
        WriteDiaryButton.makeRoundedButtnon("일지 작성하기", titleColor: .main, borderColor: UIColor.main.cgColor, backgroundColor: .white)

        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "timer")
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 목표 \(getMinutesTextByTime(readingTime))" ))
        initReadingTime(time: readingTime)
        readingTargetTimeLabel.attributedText = attributedString
        readingTargetTimeLabel.textColor = .middlegrey1
        daillyRadingTitleLabel.textColor = .charcoal
        daillyTotalReadingTimeLabel.textColor = .main
        daillyRadingSubTitleLabel.textColor = .darkgrey
    }
    
    func getMinutesTextByTime(_ time: Int) -> String {
        var text = ""
        if time > 60 {
            text = "\(time / 60)분"
        } else {
            text = "\(1)분"
        }
        return text
    }

    
    // 이전 화면에서 받은 시간(초) 기준으로 00분 00초 단위로 변환해서 레이블에 적용
    private func initReadingTime(time: Int) {
        let minutes = time / 60
        let seconds = time % 60
        let attributedTimeString = NSMutableAttributedString()
            .bold("\(minutes)", fontSize: 40)
            .normal("분", fontSize: 40)
            .bold("\(seconds)", fontSize: 40)
            .normal("초", fontSize: 40)
        daillyTotalReadingTimeLabel.attributedText = attributedTimeString
    }
    
    private func setNavBar() {
        let rightButton = UIBarButtonItem(image: UIImage(named: "shareIconLine"), style: .plain, target: self, action: #selector(shareDaillyReadingResult(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .darkgrey
        self.navigationController?.navigationBar.tintColor = .darkgrey
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

}
