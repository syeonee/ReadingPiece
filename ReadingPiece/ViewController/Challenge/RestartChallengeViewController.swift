//
//  RestartChallengeViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/25.
//

import UIKit

// 설정한 목표가 만료되어 재설정이 필요할 때 나오는 VC
// : 챌린지를 조기 달성한 경우, 챌린지 기간이 만료된 경우

class RestartChallengeViewController: UIViewController {
    var challengeName = ""
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupTitleLabel: UILabel!
    @IBOutlet weak var popupDescLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        view.isOpaque = false
        popupView.layer.cornerRadius = 14
        popupDescLabel.text = """
                                    \(challengeName)가 끝났어요.
                                    같은 목표에 다시 도전하거나,
                                    모든 것을 초기화하고 새로 시작할 수 있어요.
                              """
        retryButton.makeRoundedButtnon("목표 재도전하기", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        restartButton.makeRoundedButtnon("새로 시작하기", titleColor: .main, borderColor: UIColor.main.cgColor, backgroundColor: .white)
    }
    
    
    // 챌린지 재연장 API 호출
    @IBAction func retryChallengeAction(_ sender: UIButton) {
        
    }
    
    // 목표/책 추가 씬으로 이동 (처음 로그인하는 유저와 동일)
    @IBAction func restartChallengeAction(_ sender: UIButton) {
        
    }
    
}

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}
