//
//  CommunityViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/24.
//

import UIKit
import KeychainSwift

class CommunityViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    // 리뷰 리스트
    var feedList: [Feed] = []
    var expandedIndexSet : IndexSet = []

    
    var page : Int = 1
    var isEnd : Bool = false
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReviewData()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCell")
        
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.estimatedRowHeight = 284
        
    }
    
}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            return UITableViewCell()
        }
        cell.feedCellDelegate = self
        
//        if expandedIndexSet.contains(indexPath.row) {// 더보기 버튼을 누른 셀인 경우
//            cell.reviewLabel.numberOfLines = 0
//            cell.moreReadButton.isHidden = true
//        } else {
//            cell.reviewLabel.numberOfLines = 2
//            cell.moreReadButton.isHidden = false
//        }
 
        return cell
        
        
//        let length = 110
//        let review = feedList[indexPath.row]
//        if feedList[indexPath.row].text.utf8.count <= length {
//            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
//            let url = URL(string: review.imageURL)
//            cell.bookImageView.kf.setImage(with: url)
//            cell.bookTitleLabel.text = review.title
//            cell.authorLabel.text = review.writer
//            let rating = Double(review.star)
//            cell.ratingLabel.text = String(rating)
//            cell.reviewTextLabel.text = review.text
//            cell.isCompletedLabel.text = review.isCompleted
//            if let time = review.timeSum {
//                cell.timeLabel.text = "\(time)분"
//            } else {
//                cell.timeLabel.isHidden = true
//                cell.timeImageView.isHidden = true
//            }
//            cell.isPublicLabel.text = review.isPublic
//
//            cell.editDelegate = self
//            cell.index = indexPath.row
//
//            return cell
//        } else if more[indexPath.row] == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCell.cellID) as! ReviewCell
//            let url = URL(string: review.imageURL)
//            cell.bookImageView.kf.setImage(with: url)
//            cell.bookTitleLabel.text = review.title
//            cell.authorLabel.text = review.writer
//            let rating = Double(review.star)
//            cell.ratingLabel.text = String(rating)
//            cell.reviewTextLabel.text = cell.reviewTextLabel.getTruncatingText(originalString: review.text, newEllipsis: "..더보기", maxLines: 2)
//            cell.isCompletedLabel.text = review.isCompleted
//            if let time = review.timeSum {
//                cell.timeLabel.text = "\(time)분"
//            } else {
//                cell.timeLabel.isHidden = true
//                cell.timeImageView.isHidden = true
//            }
//            cell.isPublicLabel.text = review.isPublic
//
//            cell.moreDelegate = self
//            cell.editDelegate = self
//            cell.index = indexPath.row
//
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
//            let url = URL(string: review.imageURL)
//            cell.bookImageView.kf.setImage(with: url)
//            cell.bookTitleLabel.text = review.title
//            cell.authorLabel.text = review.writer
//            let rating = Double(review.star)
//            cell.ratingLabel.text = String(rating)
//            cell.reviewTextLabel.text = review.text
//            cell.isCompletedLabel.text = review.isCompleted
//            if let time = review.timeSum {
//                cell.timeLabel.text = "\(time)분"
//            } else {
//                cell.timeLabel.isHidden = true
//                cell.timeImageView.isHidden = true
//            }
//            cell.isPublicLabel.text = review.isPublic
//
//            cell.editDelegate = self
//            cell.index = indexPath.row
//
//            return cell
//        }
    }
}

extension CommunityViewController: FeedCellDelegate {
    func didTapMoreButton(cell: FeedCell) {
        print("")
    }
    
    func didTapEditButton(cell: FeedCell) {
        print("")
    }
    
    
}

// 수정 버튼 관련 메소드
extension CommunityViewController: ReviewEditDelegate, ReviewFullEditDelegate {
    
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
//            let storyboard = UIStoryboard(name: "Library", bundle: nil)
//            if let myViewController = storyboard.instantiateViewController(withIdentifier: "LibraryNavController") as? LibraryNavViewController {
//                self.navigationController?.pushViewController(myViewController, animated: true)
//            }
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                let vc: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabController") as! UITabBarController
//                vc.selectedIndex = 2
//                self.present(vc, animated: true, completion: nil)
//            let vc = UIStoryboard(name: "Library", bundle: nil).instantiateViewController(identifier: "LibraryController") as! LibraryViewController
//            self.present(vc, animated: true, completion: nil)
            //self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "신고", style: .destructive) { (action) in
            
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        alert.addAction(destructive)
        
        self.present(alert, animated: true, completion: nil)
    }
}


// API 호출 메소드
extension CommunityViewController {
    
    // 리뷰 조회 - 처음 화면 로드할 때
    private func loadReviewData() {
        feedTableView.showWhiteIndicator()
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: FeedRequest(token: token, page: 1,limit: 10)) { result in
            switch result {
            case .success(let response):
                self.feedTableView.dismissIndicator()
                if response.code == 1000 {
                    guard let result = response.feed else { return }
                    self.feedList = result
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
                }
                
            case .cancel(let cancel):
                self.feedTableView.dismissIndicator()
                print(cancel as Any)
            case .failure(let error):
                self.feedTableView.dismissIndicator()
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
                print(error as Any)
            }
        }
    }

}
