//
//  ChallengeCompletionViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/08.
//

import UIKit

class ChallengeCompletionViewController: UIViewController {
    @IBOutlet weak var challengeRewardImage: UIImageView!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeCakeNameLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        setNavBar()
        setFirecracker()
        continueButton.makeRoundedButtnon("계속하기", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        challengeNameLabel.textColor = .main
        challengeCakeNameLabel.textColor = .darkgrey
    }
    
    private func setNavBar() {
        let rightButton = UIBarButtonItem(image: UIImage(named: "shareIconLine"), style: .plain, target: self, action: #selector(shareDaillyReadingResult(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .darkgrey
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }
    
    private func setFirecracker() {
        let redCracker = UIImageView(image: UIImage(named: "redPeice"))
        let greenCracker = UIImageView(image: UIImage(named: "greenPeice"))
        let purpleCracker = UIImageView(image: UIImage(named: "purplePeice"))
        redCracker.frame = CGRect(x: 200, y: 200, width: 10, height: 20)
        view.addSubview(redCracker)
    }

    @objc func shareDaillyReadingResult(sender: UIBarButtonItem) {
        
    }

    @IBAction func continueReading(_ sender: UIButton) {
        
    }
    
}
