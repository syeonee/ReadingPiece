//
//  MyNavViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/24.
//

import UIKit

class MyNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layer.masksToBounds = false

        self.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationBar.layer.shadowOpacity = 0.1
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    }

}
