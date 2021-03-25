//
//  MyPieceViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/20.
//

import UIKit

class MyPieceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension MyPieceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pieceCell", for: indexPath) as? PieceCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
    
}

extension MyPieceViewController: UICollectionViewDelegate {
    
    
}

extension MyPieceViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = collectionView.bounds.width
        let insetSum = width - (151*2)
        let inset = insetSum/8
        print("inset is \(inset)")
        return UIEdgeInsets(top: 0, left: (inset*1.5), bottom: 0, right: (inset*1.5))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 151, height: 206)
    }
    
}

class PieceCell: UICollectionViewCell {
    
}
