//
//  BookSearchNavViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/25.
//

import UIKit

class BookSearchNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layer.masksToBounds = false

        self.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationBar.layer.shadowOpacity = 0.1
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    }
    
}
