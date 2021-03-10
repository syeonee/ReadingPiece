//
//  BookDetailViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/08.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    var book : Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.separatorStyle = .none
        reviewTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "bookReviewCell")
        reviewTableView.rowHeight = 189.5
    }
    
    func setUI(){
        let url = URL(string: book!.thumbnailPath)
        bookImageView.kf.setImage(with: url)
        titleLabel.text = book?.title
        authorsLabel.text = book?.authors.joined(separator: ",")
        publisherLabel.text = book?.publisher
        let year = book?.publicationDate.components(separatedBy: "-")[0]
        yearLabel.text = "\(year ?? "")년"
    }
    
    @IBAction func moreReviewTapped(_ sender: Any) {
        
    }
    
}

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: "bookReviewCell", for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
 
        return cell
    }
    
    
}
