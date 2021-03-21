//
//  ReviewViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/04.
//

import UIKit

class ReviewViewController: UIViewController {
    
    let reviewCell = ReviewCell()
    let fullReviewCell = FullReviewCell()
    let headerView = ReviewHeaderCell()
    
    // 더보기 기능을 위한 0 또는 1 값을 저장하기 위한 Array
    var more: [Int] = []
    
    // 기본 데이터 리스트는 최신순으로 자동으로 추가되어 있어야 함
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: reviewCell.cellID)
        tableView.register(UINib(nibName: "FullReviewCell", bundle: nil), forCellReuseIdentifier: fullReviewCell.cellID)
        tableView.register(UINib(nibName: "ReviewHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: headerView.identifier)
        tableView.tableFooterView = UIView()
        
        // Self-Sizing
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 263.5
        
        // 더보기 값 배열 초기화
        self.more = Array<Int>(repeating: 0, count: Review.dummyData.count)
    }

}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = Review.dummyData.count
        if count == 0 {
            let message = "아직 평가/리뷰가 없어요. \n꾸준히 독서하고 책에 대해 평가해보세요!"
            tableView.setEmptyView(image: UIImage(named: "recordIcon")!, message: message, buttonTitle: "평가/리뷰 작성하기") { [self] in
                buttonAction()
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let length = Review.dummyData[0].reviewText.utf8.count
        let review = Review.dummyData[indexPath.row]
        if Review.dummyData[indexPath.row].reviewText.utf8.count <= length {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
            cell.bookImageView.image = review.thumbnailImage
            cell.bookTitleLabel.text = review.bookTitle
            cell.authorLabel.text = review.author
            cell.ratingLabel.text = review.rating
            cell.reviewTextLabel.text = review.reviewText
            cell.likeCount.text = String(review.liked)
            cell.likeState = review.like
            cell.commentCount.text = String(review.comments)
            
            cell.editDelegate = self
            cell.likeDelegate = self
            cell.commentsDelegate = self
            cell.index = indexPath.row
            
            return cell
        } else if more[indexPath.row] == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCell.cellID) as! ReviewCell
            cell.bookImageView.image = review.thumbnailImage
            cell.bookTitleLabel.text = review.bookTitle
            cell.authorLabel.text = review.author
            cell.ratingLabel.text = review.rating
            //cell.reviewTextLabel.text = String(review.reviewText.prefix(52))
            cell.reviewTextLabel.text = cell.reviewTextLabel.getTruncatingText(originalString: review.reviewText, newEllipsis: "..더보기", maxLines: 2)
            cell.likeCount.text = String(review.liked)
            cell.likeState = review.like
            cell.commentCount.text = String(review.comments)
            
            cell.moreDelegate = self
            cell.editDelegate = self
            cell.likeDelegate = self
            cell.commentsDelegate = self
            cell.index = indexPath.row
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
            cell.bookImageView.image = review.thumbnailImage
            cell.bookTitleLabel.text = review.bookTitle
            cell.authorLabel.text = review.author
            cell.ratingLabel.text = review.rating
            cell.reviewTextLabel.text = review.reviewText
            cell.likeCount.text = String(review.liked)
            cell.likeState = review.like
            cell.commentCount.text = String(review.comments)
            
            cell.editDelegate = self
            cell.likeDelegate = self
            cell.commentsDelegate = self
            cell.index = indexPath.row
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if Review.dummyData.count == 0 {
            return nil
        } else {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerView.identifier) as! ReviewHeaderCell
            cell.count.text = String(Review.dummyData.count)
            cell.recentDelegate = self
            cell.oldDelegate = self
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if Review.dummyData.count == 0 {
            return 0
        } else {
            return 45
        }
    }
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        guard let tableViewLayoutMargin = tableViewLayoutMargin else { return }
        
        tableView.layoutMargins = tableViewLayoutMargin
    }

    /// To support safe area, all tableViews aligned on scrollView needs to be set margin for the cell's contentView and separator.
    
    @available(iOS 11.0, *)
    private var tableViewLayoutMargin: UIEdgeInsets? {
        guard let superview = parent?.view else {
            return nil
        }
        
        let defaultTableContentInsetLeft: CGFloat = 16
        return UIEdgeInsets(
            top: 0,
            left: superview.safeAreaInsets.left + defaultTableContentInsetLeft,
            bottom: 0,
            right: 0
        )
    }
    
}

// 더보기 버튼 관련 메소드
extension ReviewViewController: ReviewMoreDelegate {
    func didTapMoreButton(index: Int) {
        self.more[index] = 1
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
}

// 수정 버튼 관련 메소드
extension ReviewViewController: ReviewEditDelegate, ReviewFullEditDelegate {
    
    func didTapEditButton(index: Int) {
        showAlert(indexPath: IndexPath(row: index, section: 0))
    }
    func didTapFullEditButton(index: Int) {
        showAlert(indexPath: IndexPath(row: index, section: 0))
    }
    func showAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let success = UIAlertAction(title: "수정", style: .default) { (action) in
            print("수정하기")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            Review.dummyData.remove(at: indexPath[1])
            self.more.remove(at: indexPath[1])
            self.tableView.deleteRows(at: [IndexPath(row: indexPath[1], section: 0)], with: .left)
            self.tableView.reloadData()  // 섹션 헤더 reload 위해 사용
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        alert.addAction(destructive)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// 좋아요 기능 관련 메소드
extension ReviewViewController: ReviewLikeDelegate, ReviewFullLikeDelegate {
    func didTapLikeButton(index: Int, like: Bool) {
        if like == true {
            Review.dummyData[index].like = true
            Review.dummyData[index].liked += 1
            print("ReviewViewController - didTapLikeButton() called. +1 for like")
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            Review.dummyData[index].like = false
            Review.dummyData[index].liked -= 1
            print("ReviewViewController - didTapLikeButton() called. -1 for like")
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    func didTapFullLikeButton(index: Int, like: Bool) {
        if like == true {
            Review.dummyData[index].like = true
            Review.dummyData[index].liked += 1
            print("ReviewViewController - didTapFullLikeButton() called. +1 for like")
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            Review.dummyData[index].like = false
            Review.dummyData[index].liked -= 1
            print("ReviewViewController - didTapFullLikeButton() called. -1 for like")
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
}

// 댓글 관련 델리게이트
extension ReviewViewController: ReviewCommentsDelegate, ReviewFullCommentsDelegate {
    func didTapCommentButton() {
        if let commentVC = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "CommentController") as? CommentViewController {
            presentPanModal(commentVC)
        }
    }
    
    func didTapFullCommentButton() {
        print("ReviewViewController - didTapFullCommentButton() called")
        if let commentVC = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "CommentController") as? CommentViewController {
            presentPanModal(commentVC)
        }
    }
    
    
}

// 정렬 관련 메소드
extension ReviewViewController: ReviewLatestDelegate, ReviewOldestDelegate {
    func sortRecentFirst() {
        print("ReviewViewController - sortRecentFirst() called")
        Review.dummyData.sort(by: { $0.date > $1.date })
        tableView.reloadData()
    }
    
    func sortOldFirst() {
        print("ReviewViewController - sortOldFirst() called")
        Review.dummyData.sort(by: { $0.date < $1.date })
        tableView.reloadData()
    }
}

// 데이터가 없을 경우 표시되는 Placeholder의 버튼 이벤트 처리
extension ReviewViewController {
    func buttonAction () {
        print("평가/리뷰 작성")
        let vc = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.initializer = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
