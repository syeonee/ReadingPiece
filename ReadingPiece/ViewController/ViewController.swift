//
//  ViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {
    let cellId = ReadingBookCollectionViewCell.identifier
    @IBOutlet weak var dailyReadingView: UIView!
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var daillyReadingTimeLabel: UILabel!
    @IBOutlet weak var daillyReadingDiaryCountLabel: UILabel!
    @IBOutlet weak var radingBooksCollectionView: UICollectionView!
    // 목표 진행 현황(%) 에 따라 width 변경
    @IBOutlet weak var goalStatusBarWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.getChallengeData()
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
    
    // 챌린지 현황 조회 결과, 목표가 있으면 [수정], 없으면 [추가로 버튼 UI 변경
    // 챌린지 진행 중, 챌린지 조기 달성, 챌린지 기간 만료에 따른 화면 처리 진행
    func getChallengeData() {
        let req = GetChallengeRequest()
                                
        _ = Network.request(req: req) { (result) in
                
                switch result {
                case .success(let userResponse):
                    debugPrint("LOG",userResponse)
                case .cancel(let cancelError):
                    print(cancelError!)
                case .failure(let error):
                    debugPrint("LOG", error)
                    self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false)
            }
        }

        
        // 챌린지 기간내에 목표를 조기 달성한 경우
        
        // 챌린지 기간이 만료된 경우
//        let bookSettingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "restartChallengeVC") as! RestartChallengeViewController
//        bookSettingVC.modalTransitionStyle = .crossDissolve
//        self.present(bookSettingVC, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as? ReadingBookCollectionViewCell else { return UICollectionViewCell() }
        cell.configure()
    
        return cell
    }
    
}
