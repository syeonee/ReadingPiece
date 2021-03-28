//
//  TimerStopViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/06.
//

import UIKit

class TimerStopViewController: UIViewController {
    let userName = UserDefaults.standard.string(forKey: Constants.USERDEFAULT_KEY_GOAL_USER_NAME)
    var challengeInfo : ChallengerInfo?
    var readingTime : Int = 0
    
    @IBOutlet weak var timerStopTitleLabel: UILabel!
    @IBOutlet weak var currentRadingTimeLabel: UILabel!
    @IBOutlet weak var timerResumeButton: UIButton!
    @IBOutlet weak var writeDiaryButton: UIButton!

    // 로직 없이 UI 셋업만 하는 컴포넌트
    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var feedTitleLabel: UILabel!

    // 시간 완료 여부에 따라서 컨트롤러에서 보여줄 뷰를 교체하고 사용자에게 보여 줌
    var isFinished: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = "시간 기록"
    }

    func getUserBookReadingTime() {
        let req = GetBookReadingTimeRequest(goalBookId: 25)
        _ = Network.request(req: req) { (result) in
                
                switch result {
                case .success(let userResponse):
                    switch userResponse.code {
                    case 1000:
                        // 책 제목 화면 표시, 남은 시간 저장해서 추후 일지 작성시 전달 필요
                        print("LOG - 이전 독서시간", userResponse.message, userResponse.result?.sumtime)
                        let prevReadingTimeString = userResponse.result?.sumtime ?? "0" // 서버에서 오는 값이 string이라 변환 진행
                        let totalReadingTime = Int(prevReadingTimeString) // 오늘의 총 독서시간

                    default:
                        print("LOG - 오늘 독서시간 정보 없음")
                        self.presentAlert(title: "이전 시간 정보를 불러오지 못했습니다.", isCancelActionIncluded: false)
                    }
                case .cancel(let cancelError):
                    print(cancelError!)
                case .failure(let error):
                    self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false)
            }
        }
    }
    private func setupUI() {
        setNavBar()
        timerResumeButton.makeRoundedButtnon("마저 읽기", titleColor: .main, borderColor: UIColor.main.cgColor, backgroundColor: .white)
        writeDiaryButton.makeRoundedButtnon("일지 작성하기", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        
        let attributedTimeString = NSMutableAttributedString()
            .bold("00", fontSize: 40)
            .normal("분", fontSize: 40)
            .bold("00", fontSize: 40)
            .normal("초", fontSize: 40)
        currentRadingTimeLabel.attributedText = attributedTimeString

        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "timer")
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 00분" ))
        targetTimeLabel.attributedText = attributedString
        targetTimeLabel.textColor = .darkgrey

        timerStopTitleLabel.textColor = .darkgrey
        feedTitleLabel.textColor = .darkgrey
        targetTimeLabel.text = "\(Constants.USERDEFAULT_KEY_GOAL_TARGET_TIME)분"
    }

    private func setNavBar() {
        // extension으로 타이틀, 왼쪽 이름 없애기, 오른쪽 버튼 생성
        self.navigationItem.title = "시간 기록"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }

    @IBAction func resumeTimer(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func writeDiary(_ sender: UIButton) {
        if userName != "Reader" {
            let writeDiaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writeDiaryVC") as! DaillyReadingWritenViewController
            self.navigationController?.pushViewController(writeDiaryVC, animated: true)
        } else {
            self.presentAlert(title: "MY페이지에서 닉네임을 먼저 설정해주세요.", isCancelActionIncluded: false)
        }
    }
    
}
