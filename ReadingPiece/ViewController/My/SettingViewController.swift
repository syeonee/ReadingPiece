//
//  SettingViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var accountInfoView: UIView!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var versionView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var logoutView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noticeView.layer.addBorder([.bottom], color: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), width: 0.17)
        versionView.layer.addBorder([.bottom], color: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), width: 0.17)
        questionView.layer.addBorder([.bottom], color: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), width: 0.17)
    }
    
    @IBAction func settingViewTapped(_ sender: UITapGestureRecognizer) {
        if sender.view == noticeView {
            print("b")
        }else if sender.view == versionView {
            print("c")
        }else if sender.view == questionView {
            print("d")
        }else if sender.view == logoutView{
            print("e")
        }
    }
    

}
