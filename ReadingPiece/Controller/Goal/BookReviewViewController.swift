//
//  BookReviewViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/09.
//

import UIKit

class BookReviewViewController: UIViewController {

    @IBOutlet weak var reviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "bookReviewCell")
        reviewTableView.rowHeight = 189.5
        
    }
    
}

extension BookReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: "bookReviewCell", for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        cell.reviewCellDelegate = self
 
        return cell
    }
    
    
}

extension BookReviewViewController: ReviewTableViewCellDelegate {
    func moreTextButtonTapped(cell: ReviewTableViewCell) {
        let indexPath = reviewTableView.indexPath(for: cell)
        print("more button tapped at row-\(String(describing: indexPath?.row))")
    }
    
    func editReviewButtonTapped(cell: ReviewTableViewCell) {
        let indexPath = reviewTableView.indexPath(for: cell)
        showAlert(indexPath: indexPath!)
    }
    
    func likeButtonTapped(cell: ReviewTableViewCell) {
        let indexPath = reviewTableView.indexPath(for: cell)
        print("like button tapped at row-\(String(describing: indexPath?.row))")
    }
    
    func commentButtonTapped(cell: ReviewTableViewCell) {
        let indexPath = reviewTableView.indexPath(for: cell)
        print("comment button tapped at row-\(String(describing: indexPath?.row))")
    }
    
    func showAlert(indexPath: IndexPath) { // alert 보여줄 때 breaking constraint는 버그라고 한다.
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modify = UIAlertAction(title: "수정", style: .default) { (action) in
            print("리뷰 수정 row-\(indexPath.row)")
        }
        let remove = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            print("리뷰 삭제 row-\(indexPath.row)")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(modify)
        alert.addAction(remove)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
