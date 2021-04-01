//
//  InputReadingPercentPopupViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/12.
//

import UIKit

class InputReadingPercentPopupViewController: UIViewController {
    static var storyobardId: String = "InputReadingPercentVC"
    var readingStatusDelegate: ReadingStatusDelegate?
    
    @IBOutlet weak var popupView: UIView!
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
        readingStatusSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: UIControl.Event.valueChanged)

    }
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePopup(_ sender: UIButton) {
        if readingStatusSlider.value > 0.0 {
            let percent = Int(readingStatusSlider.value * 100)
            readingStatusDelegate?.setReadingPercent(percent)
            dismiss(animated: true, completion: nil)
        }
    }

    @objc func sliderValueChanged(_ sender: UISlider) {
        changeButtonStatus(sender.value)
        let percent = Int(sender.value * 100)
        readingPercentLabel.text = "\(percent)"
    }
    
    func changeButtonStatus(_ value: Float) {
        if value > 0.0 {
            doneButton.makeRoundedButtnon("완료", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        } else {
            doneButton.makeRoundedButtnon("완료", titleColor: .darkgrey, borderColor: UIColor.middlegrey2.cgColor, backgroundColor: .middlegrey2)
        }
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
    
}
