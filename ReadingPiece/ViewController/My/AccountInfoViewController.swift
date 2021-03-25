//
//  AccountInfoViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import UIKit

class AccountInfoViewController: UIViewController {
    @IBOutlet weak var emailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailView.layer.addBorder([.bottom], color: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), width: 0.17)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
