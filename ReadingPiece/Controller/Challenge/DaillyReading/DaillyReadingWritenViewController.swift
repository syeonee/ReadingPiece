//
//  DailyDiaryWrittenViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/06.
//

import UIKit

class DaillyReadingWritenViewController: UIViewController {
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var bookInfoView: UIView!
    @IBOutlet weak var bookThumbnailImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var readingPageInputButton: UIButton!
    @IBOutlet weak var readingPercentInputButton: UIButton!
    @IBOutlet weak var publicPostButton: UIButton!
    @IBOutlet weak var privatePostButton: UIButton!
    @IBOutlet weak var postDairyButton: UIButton!
    @IBOutlet weak var commentLengthLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewImageHeight: NSLayoutConstraint!
    
    // 구현 편의상 버튼으로 구현, 따로 연결된 Action은 없음
    // UI셋업만 진행하고, 연결된 로직은 없는 컴포넌트
    @IBOutlet weak var readingStatusButton: UIButton!
    @IBOutlet weak var totalReadingTimeButton: UIButton!
    @IBOutlet weak var readingAmountTitleLabel: UILabel!
    @IBOutlet weak var commentTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setNavBar()
        bookInfoView.layer.addBorder([.bottom], color: .middlegrey2, width: 0.5)
        readingStatusButton.makeRoundedTagButtnon("읽는 중", titleColor: .middlegrey1, borderColor: UIColor.middlegrey1.cgColor, backgroundColor: .white)
        totalReadingTimeButton.makeRoundedTagButtnon(" 00분", titleColor: .middlegrey1, borderColor: UIColor.lightgrey1.cgColor, backgroundColor: .lightgrey1)
        postDairyButton.makeRoundedButtnon("완료", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        readingPageInputButton.makeSmallRoundedButtnon("00p", titleColor: .white, borderColor: UIColor.main.cgColor, backgroundColor: .main)
        readingPercentInputButton.makeSmallRoundedButtnon("00%", titleColor: .main, borderColor: UIColor.main.cgColor, backgroundColor: .white)
        publicPostButton.makeSmallRoundedButtnon("전체 공개", titleColor: .white, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .darkgrey)
        privatePostButton.makeSmallRoundedButtnon("나만 보기", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
        bookTitleLabel.textColor = .darkgrey
        bookAuthorLabel.textColor = .darkgrey
        commentTextField.contentVerticalAlignment = .top
        commentTextField.textColor = .charcoal
        commentTextField.backgroundColor = .lightgrey1
        commentLengthLabel.textColor = .darkgrey
        
    }
    
    private func setNavBar() {
        self.navigationItem.title = "독서 일지"
        self.navigationController?.navigationBar.topItem?.title = ""
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(postDiary(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .main
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func postDiary(sender: UIBarButtonItem) {
        let writeReviewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "writeReviewVC") as! ReviewWrittenViewController
        self.navigationController?.pushViewController(writeReviewVC, animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.reviewImageHeight.constant = 75
            self.reviewImageView.image = UIImage(named: "AppIcon")
        }
    }
    
    @IBAction func pageSelect(_ sender: UIButton) {
        let inputReadingStatusVC = self.storyboard?.instantiateViewController(withIdentifier: InputReadingStatusPopupViewController.storyobardId)
        inputReadingStatusVC?.modalTransitionStyle = .crossDissolve
        self.present(inputReadingStatusVC!, animated: true, completion: nil)
    }
    
    @IBAction func percentSelect(_ sender: UIButton) {
        let inputReadingPercentVC = self.storyboard?.instantiateViewController(withIdentifier: InputReadingPercentPopupViewController.storyobardId)
        inputReadingPercentVC?.modalTransitionStyle = .crossDissolve
        self.present(inputReadingPercentVC!, animated: true, completion: nil)
    }
    
    @IBAction func makePublicPost(_ sender: UIButton) {
        print("pageSelect")
    }
    
    @IBAction func makePrivatePost(_ sender: UIButton) {
        print("pageSelect")

    }
    
    @IBAction func postDiary(_ sender: UIButton) {
        print("pageSelect")

    }
}
