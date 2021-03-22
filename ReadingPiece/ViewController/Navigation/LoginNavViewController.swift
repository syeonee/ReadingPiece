//
//  LoginNavViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/18.
//

import UIKit

class LoginNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backButtonBackgroundImage = UIImage(named: "navBack")
        let barAppearance =
            UINavigationBar.appearance(whenContainedInInstancesOf: [LoginNavViewController.self])
        barAppearance.backIndicatorImage = backButtonBackgroundImage
        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layer.masksToBounds = false

        self.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationBar.layer.shadowOpacity = 0.1
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
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
