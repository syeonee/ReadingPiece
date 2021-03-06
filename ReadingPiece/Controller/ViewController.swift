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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func startReadingAction(_ sender: UIButton) {
        let TimerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timerVC") as! TimerViewController
        self.navigationController?.pushViewController(TimerVC, animated: true)
    }
    
    @IBAction func addReadingBookAction(_ sender: UIButton) {
        // 목표 설정, 책 검색 씬으로 추후 연결
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
