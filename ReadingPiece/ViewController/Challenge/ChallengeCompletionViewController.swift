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
    }
    
    private func setupUI() {
        setNavBar()
        setFireCracker()
        continueButton.makeRoundedButtnon("계속하기", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        challengeNameLabel.textColor = .main
        challengeCakeNameLabel.textColor = .darkgrey
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
