//
//  ReviewWritingCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/11.
//

import UIKit

class ReviewWritingCell: UITableViewCell {
    
    let cellID = "ReviewWritingCell"
    var isPublic: Bool?
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
        if self.isPublic == false {
            privateButton.makeSmallRoundedButtnon("나만 보기", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
            self.isPublic = true
        } else {
            self.isPublic = true
        }
        if reviewInputTextView.text.isEmpty == false {
            delegate?.activateDoneButton()
        }
    }
    @IBAction func privateButtonTapped(_ sender: Any) {
        privateButton.makeSmallRoundedButtnon("나만 보기", titleColor: .white, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .darkgrey)
        if self.isPublic == true {
            publicButton.makeSmallRoundedButtnon("전체 공개", titleColor: .darkgrey, borderColor: UIColor.darkgrey.cgColor, backgroundColor: .white)
            self.isPublic = false
        } else {
            self.isPublic = true
        }
        if reviewInputTextView.text.isEmpty == false {
            delegate?.activateDoneButton()
        }
    }
    
}

extension ReviewWritingCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
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
    func activateDoneButton()
}
