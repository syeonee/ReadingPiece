//
//  ChallengeCompletionViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/08.
//

import UIKit
import KeychainSwift
import SpriteKit

class ChallengeCompletionViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    var sharedImage : UIImage?

    @IBOutlet weak var challengeRewardView: UIView!
    @IBOutlet weak var challengeRewardImage: UIImageView!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeCakeNameLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var fireCrackerView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        postNewUserCakeType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupUI() {
        setNavBar()
        setFireCracker()
        continueButton.makeRoundedButtnon("계속하기", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        challengeNameLabel.textColor = .main
        challengeCakeNameLabel.textColor = .darkgrey
    }
    
    // [이전 케이크와 비교하여 교체, 모든 케이크 전부 할당] 예외사항 처리 필요
    func postNewUserCakeType() {
        guard let token = keychain.get(Keys.token) else { return }
        // 유저디폴트에 있는 goalId, 케이크 이름을 받아오도록 추후 변경 필요
        let req = PostUserCakeTypeRequest(token: token, goalId: 33, cake: "bery")
        
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
        let leftButton = UIBarButtonItem(image: UIImage(named: "XButton"), style: .plain, target: self, action: #selector(backToMainVC(sender:)))
        let rightButton = UIBarButtonItem(image: UIImage(named: "shareIconLine"), style: .plain, target: self, action: #selector(shareDaillyReadingResult(sender:)))
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .darkgrey
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }
    
    @objc func shareDaillyReadingResult(sender: UIBarButtonItem) {
        shareResult()
    }

    @objc func backToMainVC(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    // 계속하기 버튼 : 메인 화면으로 이동
    @IBAction func continueReading(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
