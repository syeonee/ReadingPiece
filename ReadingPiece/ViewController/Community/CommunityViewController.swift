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

    let reviewCell = ReviewCell()
    let fullReviewCell = FullReviewCell()
    
    // 리뷰 리스트
    var feedList: [Feed] = []
    
    // 더보기 기능을 위한 0 또는 1 값을 저장하기 위한 Array
    var more: [Int] = []
    
    var page : Int = 1
    var isEnd : Bool = false
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReviewData()
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
        
        feedTableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: reviewCell.cellID)
        feedTableView.register(UINib(nibName: "FullReviewCell", bundle: nil), forCellReuseIdentifier: fullReviewCell.cellID)
        feedTableView.tableFooterView = UIView()
        
        // Self-Sizing
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.estimatedRowHeight = 263.5
        
    }
    
    func didRetrieveData() {
        self.more = Array<Int>(repeating: 0, count: feedList.count)  // 더보기 값 배열 초기화
        feedTableView.reloadData()
    }
    

}


extension CommunityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = feedList.count
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
        let review = feedList[indexPath.row]
        if feedList[indexPath.row].text.utf8.count <= length {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
            if let imagePath = review.imageURL {
                let url = URL(string: imagePath)
                cell.bookImageView.kf.setImage(with: url)
            }
            cell.bookTitleLabel.text = review.title
            cell.authorLabel.text = review.writer
            cell.ratingLabel.text = "읽는 중"
            cell.reviewTextLabel.text = review.text
            cell.isCompletedLabel.text = "\(review.percent)% 읽음"
                cell.timeLabel.text = "\(time)분"
  
            cell.isPublicLabel.isHidden = true
            
            cell.editDelegate = self
            cell.index = indexPath.row
            
            return cell
        } else if more[indexPath.row] == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCell.cellID) as! ReviewCell
            if let imagePath = review.imageURL {
                let url = URL(string: imagePath)
                cell.bookImageView.kf.setImage(with: url)
            }
            cell.bookTitleLabel.text = review.title
            cell.authorLabel.text = review.writer
            cell.ratingLabel.text = "읽는 중"
            cell.reviewTextLabel.text = cell.reviewTextLabel.getTruncatingText(originalString: review.text, newEllipsis: "..더보기", maxLines: 2)
            cell.isCompletedLabel.text = "\(review.percent)% 읽음"
                cell.timeLabel.text = "\(time)분"
            cell.isPublicLabel.isHidden = true
            cell.moreDelegate = self
            cell.editDelegate = self
            cell.index = indexPath.row
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
            if let imagePath = review.imageURL {
                let url = URL(string: imagePath)
                cell.bookImageView.kf.setImage(with: url)
            }
            cell.bookTitleLabel.text = review.title
            cell.authorLabel.text = review.writer
            cell.ratingLabel.text = "읽는 중"
            cell.reviewTextLabel.text = review.text
            cell.isCompletedLabel.text = "\(review.percent)% 읽음"
                cell.timeLabel.text = "\(time)분"
    
            cell.isPublicLabel.isHidden = true
            
            cell.editDelegate = self
            cell.index = indexPath.row
            
            return cell
        }
        
    }
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        guard let tableViewLayoutMargin = tableViewLayoutMargin else { return }
        
        feedTableView.layoutMargins = tableViewLayoutMargin
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height: CGFloat = scrollView.frame.size.height
        let contentYOffset: CGFloat = scrollView.contentOffset.y
        let scrollViewHeight: CGFloat = scrollView.contentSize.height
        let distanceFromBottom: CGFloat = scrollViewHeight - contentYOffset
                  
        if distanceFromBottom < height && !isEnd {
            addData()
        }
    }
    
    func addData(){
        page+=1
        feedTableView.showWhiteIndicator()
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: FeedRequest(token: token, page: 1,limit: 10)) { result in
            switch result {
            case .success(let response):
                self.feedTableView.dismissIndicator()
                if response.code == 1000 {
                    guard let result = response.feed else {
                        self.isEnd = true
                        return
                    }
                    self.feedList.append(contentsOf: result)
                    self.didRetrieveData()
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

// 더보기 버튼 관련 메소드
extension CommunityViewController: ReviewMoreDelegate {
    func didTapMoreButton(index: Int) {
        self.more[index] = 1
        self.feedTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
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


// 데이터가 없을 경우 표시되는 Placeholder의 버튼 이벤트 처리
extension CommunityViewController {
    func buttonAction () {
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
                    self.didRetrieveData()
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
