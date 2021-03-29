//
//  SettingViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import UIKit
import KeychainSwift

class SettingViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var accountInfoView: UIView!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var versionView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var logoutView: UIView! // 로그아웃
    @IBOutlet weak var secessionView: UIView! // 회원탈퇴
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noticeView.layer.addBorder([.bottom], color: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), width: 0.17)
        versionView.layer.addBorder([.bottom], color: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), width: 0.17)
        questionView.layer.addBorder([.bottom], color: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), width: 0.17)
        logoutView.layer.addBorder([.bottom], color: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), width: 0.17)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func settingViewTapped(_ sender: UITapGestureRecognizer) {
        switch sender.view {
        case noticeView:
            let storyboard = UIStoryboard(name: "My", bundle: nil)
            if let myViewController = storyboard.instantiateViewController(withIdentifier: "NoticeController") as? NoticeViewController {
                self.navigationController?.pushViewController(myViewController, animated: true)
            }
        case versionView:
            print()
        case questionView:
            let storyboard = UIStoryboard(name: "My", bundle: nil)
            if let myViewController = storyboard.instantiateViewController(withIdentifier: "QuestionController") as? QuestionViewController {
                self.navigationController?.pushViewController(myViewController, animated: true)
            }
        case logoutView:
            logout()
        case secessionView:
            self.presentAlert(title: "정말 탈퇴하시겠어요?", message: "탈퇴하면 데이터를 복구할 수 없습니다. ", isCancelActionIncluded: true) {_ in
                self.closeAccount()
            }
        default:
            print()
        }
    }
    
    private func logout() {
        if keychain.clear() {
            print("cleared keychain")
            self.presentAlert(title: "성공적으로 로그아웃되었습니다. ")
        } else {
            self.presentAlert(title: "로그아웃에 실패했습니다. ")
        }
    }
    
    private func closeAccount() {
        if keychain.clear() {
            print("cleared keychain")
            Network.request(req: CloseAccountRequest()) { result in
                switch result {
                case .success(let response):
                    if response.code == 1000 {
                        self.presentAlert(title: "회원 탈퇴에 성공하였습니다. ") {_ in
                            let storyboard = UIStoryboard(name: "Login", bundle: nil)
                            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginNav")
                            loginViewController.modalPresentationStyle = .fullScreen
                            self.present(loginViewController, animated: true, completion: nil) 
                        }
                    } else {
                        let message = response.message
                        self.presentAlert(title: message)
                    }
                case .cancel, .failure:
                    self.presentAlert(title: "회원 탈퇴에 실패했습니다. ")
                }
            }
        }
        self.presentAlert(title: "회원 탈퇴에 실패했습니다. ")
    }
    
    
}
