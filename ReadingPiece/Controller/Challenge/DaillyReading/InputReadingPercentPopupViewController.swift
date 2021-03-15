//
//  InputReadingPercentPopupViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/12.
//

import UIKit

class InputReadingPercentPopupViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    static var storyobardId: String = "InputReadingPercentVC"
    @IBOutlet weak var closePopupButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var popupTitleLabel: UILabel!
    @IBOutlet weak var readingPercentLabel: UILabel!
    @IBOutlet weak var readingStatusSlider: UISlider!
    
    // "%" 레이블
    @IBOutlet weak var readingPercentTitleLabel: UILabel!
    // r
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        view.isOpaque = false
        popupView.layer.cornerRadius = 14
        closePopupButton.tintColor = .darkgrey
        readingPercentLabel.textColor = .main
        readingPercentTitleLabel.textColor = .main
        readingStatusSlider.tintColor = .darkgrey
        doneButton.makeRoundedButtnon("완료", titleColor: .darkgrey, borderColor: UIColor.middlegrey2.cgColor, backgroundColor: .middlegrey2)
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePopup(_ sender: UIButton) {
        
        
    }
}
