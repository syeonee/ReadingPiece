//
//  ReadingBookCollectionViewCell.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/15.
//

import UIKit

class ReadingBookCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "ReadingBookCollectionViewCell"
    @IBOutlet weak var bookThumbnail: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var currentPercentLabel: UILabel!
    @IBOutlet weak var radingTimeLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure() {
        setupUI()
    }
    
    private func setupUI() {
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
        bgView.layer.borderColor = UIColor.darkgrey.cgColor
    }
    
}
