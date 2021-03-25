//
//  ReviewHeaderCell.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/05.
//

import UIKit
import DropDown

class ReviewHeaderCell: UITableViewHeaderFooterView {
    let identifier = "ReviewHeaderCell"
    
    var recentDelegate: ReviewLatestDelegate?
    var oldDelegate: ReviewOldestDelegate?
    
    let dropDown: DropDown = {
        let menu = DropDown()
        menu.dataSource = ["최신순", "오래된 순"]
        menu.cellNib = UINib(nibName: "ReviewDropDownCell", bundle: nil)
        return menu
    }()
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var alignStackView: UIStackView!
    @IBOutlet weak var alignStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAlignTap()
        dropDown.anchorView = alignStackView
        dropDown.bottomOffset = CGPoint(x: 0, y: alignStackView.bounds.height)
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 5
    }
    
    func setupAlignTap() {
        let alignTap = UITapGestureRecognizer(target: self, action: #selector(self.alignViewTapped(_:)))
        self.alignStackView.isUserInteractionEnabled = true
        self.alignStackView.addGestureRecognizer(alignTap)
    }
    
    @objc func alignViewTapped(_ sender: UITapGestureRecognizer) {
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.alignStatusLabel.text = "\(item)"
            if item == "최신순" {
                recentFirst()
            } else {
                oldFirst()
            }
        }
    }
    
    func recentFirst() {
        recentDelegate?.sortRecentFirst()
    }
    
    func oldFirst() {
        oldDelegate?.sortOldFirst()
    }
    
    
}
protocol ReviewLatestDelegate {
    func sortRecentFirst()
}

protocol ReviewOldestDelegate {
    func sortOldFirst()
}
