//
//  ChallengeCompletionViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/08.
//

import UIKit
import SpriteKit

class ChallengeCompletionViewController: UIViewController {

    @IBOutlet weak var challengeRewardView: UIView!
    @IBOutlet weak var challengeRewardImage: UIImageView!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeCakeNameLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var fireCrackerView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        postNewUserCakeType()
    }
    
    private func setupUI() {
        setNavBar()
        setFireCracker()
        continueButton.makeRoundedButtnon("계속하기", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        challengeNameLabel.textColor = .main
        challengeCakeNameLabel.textColor = .darkgrey
    }
    
    func postNewUserCakeType() {
        // 유저디폴트에 있는 goalId, 케이크 이름을 받아오도록 추후 변경 필요
        let req = PostUserCakeTypeRequest(goalId: 33, cake: "bery")
        
        _ = Network.request(req: req) { (result) in
                switch result {
                case .success(let userResponse):
                    switch userResponse.code {
                    case 1000:
                        print("LOG - 케이크 종류 변경 성공", userResponse.code)
                    default:
                        print("LOG - 케이크 종류 변경 실패", userResponse.message, userResponse.code)
                    }
                case .cancel(let cancelError):
                    print(cancelError!)
                case .failure(let error):
                    debugPrint("LOG", error)
            }
        }
    }
    
    func setFireCracker() {
        self.fireCrackerView.backgroundColor = .clear
        let scene = FireCrackerScene()
        self.fireCrackerView.presentScene(scene)
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

    @IBAction func continueReading(_ sender: UIButton) {
        //        챌린지 달성 시점에 해당 책에대한 리뷰 작성 화면으로 이동, 추후 구현
        //        let writeReviewVC = UIStoryboard(name: "Library", bundle: nil).instantiateViewController(withIdentifier: "writeReviewVC") as! ReviewWrittenViewController
        //        self.navigationController?.pushViewController(writeReviewVC, animated: true)
    }
    
    func shareResult() {
        let image = challengeRewardView.captureScreenToImage()
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        self.present(activityViewController, animated: true, completion: nil)
    }
        
}


extension UIView {    
    func captureScreenToImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image {
            rendererContext in layer.render(in: rendererContext.cgContext)
        }
    }
}
