//
//  ViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {
    let cellId = ReadingBookCollectionViewCell.identifier
    var challengeInfo : ChallengerInfo? { didSet {
        radingBooksCollectionView.reloadData()
    }}
    var goalInitializer = 0

    // 데이터 파싱 결과에 따라 변경할 이미지
    @IBOutlet weak var userReadingGoalLabel: UILabel!
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var goalStatusBarWidth: NSLayoutConstraint! // 목표 진행 현황(%) 에 따라 width 변경
    @IBOutlet weak var statusBarWidth: NSLayoutConstraint! // 목표 진행 현황(%) 에 따라 width 변경
    @IBOutlet weak var targetReadingBookCountLabel: UILabel!
    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var currentReadingBookCountLabel: UILabel!
    @IBOutlet weak var daillyReadingTimeLabel: UILabel!
    @IBOutlet weak var daillyReadingDiaryCountLabel: UILabel!
    @IBOutlet weak var challengeImageView: UIImageView!

    
    // 데이터 변경 없는 Outlet
    @IBOutlet weak var statusBar: UIView!
    @IBOutlet weak var dailyReadingView: UIView!
    @IBOutlet weak var radingBooksCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.initMainView()
        }
    }

    @IBAction func startReadingAction(_ sender: UIButton) {
        let TimerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timerVC") as! TimerViewController
        self.navigationController?.pushViewController(TimerVC, animated: true)
    }
    
    @IBAction func modifyReadingGoalAction(_ sender: UIButton) {
        let modifyReadingGaolVC = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(withIdentifier: "TermViewController") as! TermViewController
        self.navigationController?.pushViewController(modifyReadingGaolVC, animated: true)
    }
    
    func postUserReadingGoal() {

    }
    
    @IBAction func addReadingBookAction(_ sender: UIButton) {
        let bookSettingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "bookSettingVC") as! BookSettingViewController
        self.navigationController?.pushViewController(bookSettingVC, animated: true)
    }
    
    private func setupUI() {
        setupCollectionView()
        makeDaillyReadingViewShadow()
    }
    
    func makeDaillyReadingViewShadow() {
        dailyReadingView.layer.shadowRadius = 5
        dailyReadingView.layer.shadowColor = UIColor.black.cgColor
        dailyReadingView.layer.shadowOpacity = 0.2
        dailyReadingView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func setupCollectionView() {
        radingBooksCollectionView.delegate = self
        radingBooksCollectionView.dataSource = self
        self.radingBooksCollectionView.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        setupFlowLayout()
    }
    
    func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: self.radingBooksCollectionView.layer.bounds.width - 50, height: 138)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 10.0
        radingBooksCollectionView.collectionViewLayout = flowLayout
    }
    
    func initMainView() {
        getChallengeRequest().getChallengeRequest { (challengeData) in
            switch challengeData {
            case nil :
                self.presentAlert(title: "서버 연결 상태가 원활하지 않습니다.", isCancelActionIncluded: false)
            // 챌린지 진행 중, 챌린지 조기 달성, 챌린지 기간 만료에 따른 화면 처리 먼저 진행
            default :
                print("LOG 챌린지 목표 정보 조회 성공")
                self.challengeInfo = challengeData
                // 챌린지 정보 조회 결과, 참여 기간이 만료된 경우
                if self.challengeInfo?.isExpired == true {
                    self.showRestartChallengePopup()
                // 목표 재시작이 필요한 경우를 제외한, 일반적인 상황
                } else if self.challengeInfo?.readingBook.first?.isComplete == 1 {
                    self.showRestartChallengePopup()
                } else {
                    self.initVC()
                }
            }
        }
    }

    func showRestartChallengePopup() {
        let bookSettingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "restartChallengeVC") as! RestartChallengeViewController
        bookSettingVC.modalTransitionStyle = .crossDissolve
        self.present(bookSettingVC, animated: true, completion: nil)
    }
    
    // 목표 설정 화면 진입 전에, 처음 추가한 목표인지 or 기존 목표 수정인지 여부를 판단하고 적용
    // 데이터 파싱 완료 이후, 유저에게 보여줄 데이터를 VC에 적용
    func initVC() {
        if let challenge = self.challengeInfo?.todayChallenge, let goal = self.challengeInfo?.readingGoal.first {
            let targetBookAmount = challenge.amount ?? 0// 읽기 목표 권수
            let userName = challenge.name ?? "리피"//
            let period = challenge.period ?? "D"// 읽기 주기
            let formattedPeriod = getDateFromPeriod(period: period)

            let targetTime = challenge.time ?? 0
            let todayTime = challenge.todayTime ?? "0" // 오늘 읽은 시간
            let totalReadingDiary = challenge.totalJournal ?? 0// 챌린지 기간동안 읽은 책 권수
            let readBookAmount = challenge.totalReadBook ?? 0
            let dDay = challenge.dDay ?? 0 // 챌린지 남은 기간
            let percent = goal.percent ?? 0 // 챌린지 달성도
            let cgFloatPercent = CGFloat(percent) * 0.1

            userReadingGoalLabel.text = "\(userName)님은 \(formattedPeriod)동안\n\(targetBookAmount)권 읽기에 도전 중"
            goalStatusBarWidth.constant = statusBar.frame.width * cgFloatPercent
            daillyReadingTimeLabel.text = todayTime
            daillyReadingDiaryCountLabel.text = "\(totalReadingDiary)"
            targetReadingBookCountLabel.text = "\(targetBookAmount)"
            targetTimeLabel.text = "\(targetTime)분"
            currentReadingBookCountLabel.text = "\(readBookAmount)권 / "
            dDayLabel.text = "\(dDay)일 남음"
        }
    }
    
    private func getDateFromPeriod(period: String) -> String {
        switch period {
        case "D": return "한 주"
        case "M": return "한 달"
        default: return "일 년"
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as? ReadingBookCollectionViewCell else { return UICollectionViewCell() }
        let book = self.challengeInfo?.readingBook.first
        let goal = self.challengeInfo?.readingGoal.first
        cell.configure(data: book, readingStatus: goal)
        
        return cell
    }
    
}
