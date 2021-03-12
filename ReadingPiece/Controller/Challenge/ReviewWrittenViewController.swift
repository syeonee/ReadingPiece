//
//  ReviewWrittenViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/11.
//

import UIKit

class ReviewWrittenViewController: UIViewController {
    
    @IBOutlet weak var publishedYearLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var reviewInputTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var privatePostButton: UIButton!
    @IBOutlet weak var publicPostButton: UIButton!
    @IBOutlet weak var bookThumbnailImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    // 별 평점이 속한 뷰 그룹
    @IBOutlet weak var reviewRatingView: UIView!
    // "나의 평가" : 로직없이 UI만 적용
    @IBOutlet weak var reviewRatingTitleLabel: UILabel!
    // "리뷰" : 로직없이 UI만 적용
    @IBOutlet weak var reviewTitleLabel: UILabel!
    // "지음" : 로직없이 UI만 적용
    @IBOutlet weak var publisherTitleLabel: UILabel!
    // "펴냄" : 로직없이 UI만 적용
    @IBOutlet weak var authorTitleLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setNavBar()
        bookTitleLabel.textColor = .charcoal
        authorLabel.textColor = .charcoal
        authorTitleLabel.textColor = .middlegrey1
        publisherLabel.textColor = .charcoal
        publisherTitleLabel.textColor = .middlegrey1
        publishedYearLabel.textColor = .charcoal
        reviewRatingView.layer.addBorder([.top, .bottom], color: .middlegrey1, width: 0.5)
        reviewInputTextField.backgroundColor = .lightgrey1
        reviewInputTextField.textColor = .middlegrey1
        reviewInputTextField.layer.borderWidth = 0
        reviewInputTextField.contentVerticalAlignment = .top
        publicPostButton.makeSmallRoundedButtnon("전채 공개", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
        privatePostButton.makeSmallRoundedButtnon("나만 보기", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
        postButton.makeRoundedButtnon("완료", titleColor: .middlegrey1, borderColor: UIColor.fillDisabled.cgColor, backgroundColor: .fillDisabled)
    }

    private func setNavBar() {
        self.navigationItem.title = "평가/리뷰"
        self.navigationController?.navigationBar.topItem?.title = ""
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(postReview(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .main
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }
    
    @objc func postReview(sender: UIBarButtonItem) {
        
    }

    @IBAction func makePublicPost(_ sender: UIButton) {

    }

    @IBAction func makePrivatePost(_ sender: UIButton) {
        
    }
    
    @IBAction func postReview(_ sender: UIButton) {
        
    }
}
