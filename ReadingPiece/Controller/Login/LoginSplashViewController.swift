//
//  LoginSplashViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/18.
//

import UIKit

class LoginSplashViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let ud = UserDefaults.standard
        print("로그인 여부: ", ud.bool(forKey: "loginConnected"))
        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginWithApple(_ sender: Any) {
        // 애플로그인 처리
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
