//
//  FeedCell.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/29.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bookBackView: UIView!
    
    @IBOutlet weak var impressionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var textConstraint: NSLayoutConstraint!
    
    var feedCellDelegate: FeedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        feedCellDelegate?.didTapEditButton(cell: self)
    }
    @IBAction func moreButtonTapped(_ sender: Any) {
        feedCellDelegate?.didTapMoreButton(cell: self)
    }
    
}

protocol FeedCellDelegate {
    func didTapMoreButton(cell: FeedCell)
    func didTapEditButton(cell: FeedCell)
}
