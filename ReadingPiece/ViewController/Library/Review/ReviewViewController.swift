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
    
    // 리뷰 리스트
    var reviewList = [GetReviewResult]()
    
    // 더보기 기능을 위한 0 또는 1 값을 저장하기 위한 Array
    var more: [Int] = []
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReviewData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReviewData), name: Notification.Name("GetReviewData"), object: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: reviewCell.cellID)
        tableView.register(UINib(nibName: "FullReviewCell", bundle: nil), forCellReuseIdentifier: fullReviewCell.cellID)
        tableView.register(UINib(nibName: "ReviewHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: headerView.identifier)
        tableView.tableFooterView = UIView()
        
        // Self-Sizing
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 263.5
        
    }
    
    func didRetrieveData() {
        self.more = Array<Int>(repeating: 0, count: reviewList.count)  // 더보기 값 배열 초기화
        tableView.reloadData()
    }
    
    @objc func reloadReviewData(notification: NSNotification) {
        getReviewData(align: "desc")
    }

}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = reviewList.count
        if count == 0 {
            let message = "아직 평가/리뷰가 없어요. \n꾸준히 독서하고 책에 대해 평가해보세요!"
            tableView.setEmptyView(image: UIImage(named: "recordIcon")!, message: message, buttonType: "review") {
                self.buttonAction()
            }
        } else {
            tableView.restoreWithLine()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let length = 110
        let review = reviewList[indexPath.row]
        if reviewList[indexPath.row].text.utf8.count <= length {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
            let url = URL(string: review.imageURL)
            cell.bookImageView.kf.setImage(with: url,placeholder: UIImage(named: "defaultBookImage"), completionHandler: nil)
            cell.bookTitleLabel.text = review.title
            cell.authorLabel.text = review.writer
            let rating = Double(review.star)
            cell.ratingLabel.text = String(rating)
            cell.reviewTextLabel.text = review.text
            cell.isCompletedLabel.text = review.isCompleted
            if let time = review.timeSum {
                cell.timeLabel.text = "\(time)분"
            } else {
                cell.timeLabel.isHidden = true
                cell.timeImageView.isHidden = true
            }
            cell.isPublicLabel.text = review.isPublic
            
            cell.editDelegate = self
            cell.index = indexPath.row
            
            return cell
        } else if more[indexPath.row] == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCell.cellID) as! ReviewCell
            let url = URL(string: review.imageURL)
            cell.bookImageView.kf.setImage(with: url,placeholder: UIImage(named: "defaultBookImage"), completionHandler: nil)
            cell.bookTitleLabel.text = review.title
            cell.authorLabel.text = review.writer
            let rating = Double(review.star)
            cell.ratingLabel.text = String(rating)
            cell.reviewTextLabel.text = cell.reviewTextLabel.getTruncatingText(originalString: review.text, newEllipsis: "..더보기", maxLines: 2)
            cell.isCompletedLabel.text = review.isCompleted
            if let time = review.timeSum {
                cell.timeLabel.text = "\(time)분"
            } else {
                cell.timeLabel.isHidden = true
                cell.timeImageView.isHidden = true
            }
            cell.isPublicLabel.text = review.isPublic
            
            cell.moreDelegate = self
            cell.editDelegate = self
            cell.index = indexPath.row
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
            let url = URL(string: review.imageURL)
            cell.bookImageView.kf.setImage(with: url,placeholder: UIImage(named: "defaultBookImage"), completionHandler: nil)
            cell.bookTitleLabel.text = review.title
            cell.authorLabel.text = review.writer
            let rating = Double(review.star)
            cell.ratingLabel.text = String(rating)
            cell.reviewTextLabel.text = review.text
            cell.isCompletedLabel.text = review.isCompleted
            if let time = review.timeSum {
                cell.timeLabel.text = "\(time)분"
            } else {
                cell.timeLabel.isHidden = true
                cell.timeImageView.isHidden = true
            }
            cell.isPublicLabel.text = review.isPublic
            
            cell.editDelegate = self
            cell.index = indexPath.row
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if reviewList.count == 0 {
            return nil
        } else {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerView.identifier) as! ReviewHeaderCell
            cell.count.text = String(reviewList.count)
            cell.recentDelegate = self
            cell.oldDelegate = self
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if reviewList.count == 0 {
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
        showAlert(index: index)
    }
    func didTapFullEditButton(index: Int) {
        showAlert(index: index)
    }
    func showAlert(index: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let success = UIAlertAction(title: "수정", style: .default) { (action) in
            print("수정하기")
            let reviewID = self.reviewList[index].reviewID
            let reviewVC = CreateReviewViewController()
            reviewVC.reviewID = reviewID
            self.navigationController?.pushViewController(reviewVC, animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            // 리뷰 삭제 api 호출
            self.deleteReview(reviewID: self.reviewList[index].reviewID, index: index)
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        alert.addAction(destructive)
        
        self.present(alert, animated: true, completion: nil)
    }
    func didDeleteData(index: Int) {
        self.presentAlert(title: "리뷰가 삭제되었습니다. ", isCancelActionIncluded: false)
        self.reviewList.remove(at: index)
        self.more.remove(at: index)
        self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        self.tableView.reloadData()  // 섹션 헤더 reload 위해 사용
    }
}

// 정렬 관련 메소드
extension ReviewViewController: ReviewLatestDelegate, ReviewOldestDelegate {
    func sortRecentFirst() {
        getReviewData(align: "desc") // 최신순 정렬
    }
    
    func sortOldFirst() {
        getReviewData(align: "asc") // 오래된 순 정렬
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

// API 호출 메소드
extension ReviewViewController {
    
    // 리뷰 조회 - 처음 화면 로드할 때
    private func loadReviewData() {
        tableView.showWhiteIndicator()
        Network.request(req: GetReviewRequest(align: "desc")) { result in
            switch result {
            case .success(let response):
                self.tableView.dismissIndicator()
                if response.code == 1000 {
                    guard let result = response.results else { return }
                    self.reviewList = result
                    self.didRetrieveData()
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
                }
                
            case .cancel(let cancel):
                self.tableView.dismissIndicator()
                print(cancel as Any)
            case .failure(let error):
                self.tableView.dismissIndicator()
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
                print(error as Any)
            }
        }
    }
    
    // 리뷰 조회 - 정렬 바꿀때
    private func getReviewData(align: String) {
        self.spinner.startAnimating()
        Network.request(req: GetReviewRequest(align: align)) { result in
            switch result {
            case .success(let response):
                self.spinner.stopAnimating()
                if response.code == 1000 {
                    guard let result = response.results else { return }
                    self.reviewList = result
                    self.didRetrieveData()
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
                }
                
            case .cancel(let cancel):
                self.spinner.stopAnimating()
                print(cancel as Any)
            case .failure(let error):
                self.spinner.stopAnimating()
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
                print(error as Any)
            }
        }
    }
    
    // 리뷰 삭제
    private func deleteReview(reviewID: Int, index: Int) {
        Network.request(req: DeleteReviewRequest(reviewID: reviewID)) { result in
            switch result {
            case .success(let response):
                print(response)
                print("reviewID:", reviewID)
                if response.code == 1000 {
                    self.didDeleteData(index: index)
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
                }
            case .cancel(let cancelError):
                print(cancelError as Any)
            case .failure(let error):
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
                print(error?.localizedDescription as Any)
            }
        }
    }
}
