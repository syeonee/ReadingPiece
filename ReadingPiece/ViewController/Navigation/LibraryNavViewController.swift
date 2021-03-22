//
//  LibraryNavViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/24.
//

import UIKit

class LibraryNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 바 border line 없애기
        self.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layoutIfNeeded()
        
    }
    

    /*
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layer.masksToBounds = false

        self.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationBar.layer.shadowOpacity = 0.1
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    }
    */
    
}
