//
//  CommunityViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/24.
//

import UIKit

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

// 수정 기능 관련
extension CommunityViewController: JournalEditDelegate, FullJournalEditDelegate {
    func didTapEditButton(index: Int) {
        showAlert(index: index)
    }
    
    func didTapFullEditButton(index: Int) {
        showAlert(index: index)
    }
    
    func showAlert(index: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let success = UIAlertAction(title: "수정", style: .default) { (action) in
            print("게시글 작성자만 게시글 수정")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            Journal.dummyData.remove(at: index)
            self.more.remove(at: index)
            self.journalTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            self.journalTableView.reloadData()  // 섹션 헤더 reload 위해 사용
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

extension CommunityViewController {
    // 테이블 뷰에 데이터가 없을 경우 표시되는 placeholder
    func setEmptyView(image: UIImage, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let imageView = UIImageView()
        let messageLabel = UILabel()
        let button = UIButton()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.font = .NotoSans(.medium, size: 15)
        messageLabel.textColor = .charcoal
        button.titleLabel?.font = .NotoSans(.medium, size: 15)
        button.makeRoundedButtnon("독서 시작하기", titleColor: .white, borderColor: UIColor.melon.cgColor, backgroundColor: .melon)
        
        emptyView.addSubview(imageView)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(button)
        emptyView.backgroundColor = #colorLiteral(red: 0.9646214843, green: 0.9647600055, blue: 0.9645912051, alpha: 1)
        
        //imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 42).isActive = true
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 57).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 63).isActive = true
        messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 80).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -80).isActive = true
        button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 40).isActive = true
        button.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 40).isActive = true
        button.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        
        imageView.image = image
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.journalTableView.backgroundView = emptyView
        self.journalTableView.separatorStyle = .none
    }
    
    @objc func buttonAction (_ sender: UIButton!) {
        print("독서 시작 - 홈탭으로 이동 후 타이머 VC로 이동해야 함")
        
        //let homeNavigationVC = MyNavViewController()
        //let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "") as! MyNavViewController
        
        /*
        let timerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timerVC") as! TimerViewController
        //self.navigationController?.pushViewController(TimerVC, animated: true)
        
        let viewControllers = self.navigationController!.viewControllers
        let newViewControllers = NSMutableArray()
        
        // preserve the root view controller
        newViewControllers.add(viewControllers[0])
        // add the new view controller
        newViewControllers.add(timerVC)
        self.navigationController?.setViewControllers(newViewControllers as! [UIViewController], animated: true)
        */
    }
}
