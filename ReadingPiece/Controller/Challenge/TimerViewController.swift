//
//  TimerViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/03.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var challenegeTimeLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var timerBackgroundView: UIView!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func setupUI() {
        timerBackgroundView.layer.borderWidth = 5
        timerBackgroundView.layer.borderColor = UIColor.stopWatchNumberBlack.cgColor
        timerBackgroundView.layer.cornerRadius = timerBackgroundView.bounds.height / 2
        
        bookTitleLabel.textColor = .black
        challenegeTimeLabel.textColor = .subtitleGray
    }

}
