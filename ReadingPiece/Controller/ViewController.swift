//
//  ViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dailyReadingView: UIView!
    @IBOutlet weak var readingBookImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 오늘의 독서 view에 그림자 넣는 코드
        dailyReadingView.layer.shadowRadius = 5
        dailyReadingView.layer.shadowColor = UIColor.black.cgColor
        dailyReadingView.layer.shadowOpacity = 0.2
        dailyReadingView.layer.shadowOffset = CGSize(width: 0, height: 0)

    }


}

