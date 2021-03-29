//
//  MyPieceViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/20.
//

import UIKit
import KeychainSwift

class MyPieceViewController: UIViewController {
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var myPieceCollectionView: UICollectionView!
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
        
        var myPieces: [Piece] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setPiece()
        }
        @IBAction func infoButtonTapped(_ sender: Any) {
            let storyboard = UIStoryboard(name: "My", bundle: nil)
            if let myViewController = storyboard.instantiateViewController(withIdentifier: "PieceInfoController") as? PieceInfoViewController {
                presentPanModal(myViewController)
            }
        }
        
        func setPiece(){
            self.showIndicator()
            guard let token = keychain.get(Keys.token) else { return }
            Network.request(req: MyPieceRequest(token: token)) { [self] result in
                self.dismissIndicator()
                print("set piece = \(result)")
                switch result {
                case .success(let response):
                    self.dismissIndicator()
                    let result = response.code
                    if result == 1000 {
                        if response.message == "나의 피스 조회 성공."{
                            DispatchQueue.main.async {
                                if let pieces = response.pieces{
                                    myPieces = pieces
                                    print("pie = \(myPieces)")
                                    myPieceCollectionView.reloadData()
                                }
                            }
                        }
                    } else {
                        self.presentAlert(title: response.message, isCancelActionIncluded: false) {_ in
                        }
                    }
                case .cancel(let cancelError):
                    self.dismissIndicator()
                    print(cancelError as Any)
                case .failure(let error):
                    self.dismissIndicator()
                    print(error as Any)
                    self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false) {_ in
                    }
                }
            }
        }
        
    }

    extension MyPieceViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if myPieces.count == 0 {
                let bundle = Bundle(for: type(of: self))
                let nib = UINib(nibName: "PieceEmptyView", bundle: bundle)
                        
                collectionView.backgroundView = nib.instantiate(withOwner: self, options: nil).first as? UIView
            }else{
                collectionView.backgroundView = nil
            }
            return myPieces.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pieceCell", for: indexPath) as? PieceCell else {
                return UICollectionViewCell()
            }
            
            let piece = myPieces[indexPath.item]
            cell.challengeLabel.text = piece.challengeName
            cell.durationLabel.text = piece.challengePeriod
            
            if piece.isComplete == "달성" {
                cell.completeImageView.image = UIImage(named: "myComplete")
            } else {
                cell.completeImageView.image = UIImage(named: "myOngoing")
            }
            
            switch piece.cake {
            case "cream":
                cell.cakeImageVIew.image = UIImage(named: "myCream")
            case "choco":
                cell.cakeImageVIew.image = UIImage(named: "myChoco")
            case "berry":
                cell.cakeImageVIew.image = UIImage(named: "myBlueberry")
            default:
                cell.cakeImageVIew.image = UIImage(named: "myCream")
            }
            
            if piece.wholeCake == "홀케이크" {
                cell.wholecakeImageView.image = UIImage(named: "myWholeCake")
            } else {
                cell.wholecakeImageView.isHidden = true
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
            return UIEdgeInsets(top: 0, left: (inset*1.8), bottom: 0, right: (inset*1.8))
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 151, height: 206)
        }
        
    }

class PieceCell: UICollectionViewCell {
    @IBOutlet weak var completeImageView: UIImageView!
    @IBOutlet weak var cakeImageVIew: UIImageView!
    @IBOutlet weak var challengeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var wholecakeImageView: UIImageView!
}
