//
//  ReviewImage.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/18.
//

import UIKit

class ReviewImageView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var popReviewImageButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ReviewImageView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
