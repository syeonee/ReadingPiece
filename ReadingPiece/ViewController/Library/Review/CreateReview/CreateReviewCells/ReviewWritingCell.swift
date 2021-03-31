//
//  ReviewWritingCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/11.
//

import UIKit

class ReviewWritingCell: UITableViewCell {
    
    let cellID = "ReviewWritingCell"
    var isPublic: Int? // 전체공개가 1, 나만보기가 0
    var delegate: ReviewWritingCellDelegate?

    @IBOutlet weak var reviewInputTextView: UITextView!
    @IBOutlet weak var publicButton: UIButton!
    @IBOutlet weak var privateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    private func setUI() {
        reviewInputTextView.backgroundColor = .lightgrey1
        reviewInputTextView.textColor = .middlegrey1
        reviewInputTextView.layer.cornerRadius = 8
        reviewInputTextView.returnKeyType = .done
        reviewInputTextView.delegate = self
        publicButton.makeSmallRoundedButtnon("전체 공개", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
        publicButton.titleLabel?.font = .NotoSans(.medium, size: 16)
        privateButton.makeSmallRoundedButtnon("나만 보기", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
        privateButton.titleLabel?.font = .NotoSans(.medium, size: 16)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reviewInputTextView.resignFirstResponder()
    }
    
    
    @IBAction func publicButtonTapped(_ sender: Any) {
        publicButton.makeSmallRoundedButtnon("전체 공개", titleColor: .white, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .darkgrey)
        if self.isPublic == 0 {
            privateButton.makeSmallRoundedButtnon("나만 보기", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
            self.isPublic = 1
        } else {
            self.isPublic = 1
        }
        if reviewInputTextView.text.isEmpty == false {
            delegate?.activateDoneButton(text: self.reviewInputTextView.text, isPublic: self.isPublic ?? 1)
        }
    }
    @IBAction func privateButtonTapped(_ sender: Any) {
        privateButton.makeSmallRoundedButtnon("나만 보기", titleColor: .white, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .darkgrey)
        if self.isPublic == 1 {
            publicButton.makeSmallRoundedButtnon("전체 공개", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
            self.isPublic = 0
        } else {
            self.isPublic = 0
        }
        if reviewInputTextView.text.isEmpty == false {
            delegate?.activateDoneButton(text: self.reviewInputTextView.text, isPublic: self.isPublic ?? 1)
        }
    }
    
}

extension ReviewWritingCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        guard textView.text!.count < 500 else { return false }
        return true
    }
    
    // UITextView Placeholder 설정
    func textViewSetupView() {
        if reviewInputTextView.text == "기억에 남는 문구, 소감을 기록하세요!" {
            reviewInputTextView.text = ""
            reviewInputTextView.textColor = UIColor.black
        } else if reviewInputTextView.text == "" {
            reviewInputTextView.text = "기억에 남는 문구, 소감을 기록하세요!"
            reviewInputTextView.textColor = .middlegrey1
        } else {
            reviewInputTextView.textColor = UIColor.black
        }
    }
    
    // 편집이 시작될때
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    // 편집이 종료될때
    func textViewDidEndEditing(_ textView: UITextView) {
        if reviewInputTextView.text == "" {
            textViewSetupView()
        }
    }
}

protocol ReviewWritingCellDelegate {
    func activateDoneButton(text: String, isPublic: Int)
}
