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
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    let orderCurrency = "ALL"
    let paymentCurrency = "KRW"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        _ = Network.request(req: BithumbRequest(order: orderCurrency, payment: paymentCurrency)) { (result) in
                
                switch result {
                case .success(let userResponse):
                    print(userResponse)
                case .cancel(let cancelError):
                    print(cancelError!)
                case .failure(let error):
                    print(error!)
            }
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
    
    @IBAction func addReadingBookAction(_ sender: UIButton) {
        let searchBookVC = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "SearchViewController") as! SearchViewController
//        vc.initializer = 1
        self.navigationController?.pushViewController(searchBookVC, animated: true)
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
