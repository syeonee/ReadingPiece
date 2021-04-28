//
//  AccountInfoViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import UIKit
import KeychainSwift

class AccountInfoViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .darkgrey

        if let email = keychain.get(Keys.email) {
            emailLabel.text = email
        }
        emailView.layer.addBorder([.bottom], color: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), width: 0.5)
    }
    
}
