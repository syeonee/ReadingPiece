//
//  CommunityViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/24.
//

import UIKit
import KeychainSwift
import SnapKit

class CommunityViewController: UIViewController {

    // 리뷰 리스트
    var feedList: [Feed] = []
    var expandedIndexSet : IndexSet = []

    
    var page : Int = 0
    let limit : Int = 5
    var isEnd : Bool = false
    var isLoaded : Bool = false
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReviewData(page: 0, limit: limit)
        feedTableView.alwaysBounceVertical = true
        initRefresh()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCell")
        
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.estimatedRowHeight = 284
        
    }
    
    func initRefresh(){
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        feedTableView.addSubview(refresh)
    }
    
    @objc func updateUI(refresh: UIRefreshControl){
        refresh.endRefreshing()
        loadReviewData(page: 0, limit: limit)
    }
    
}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if feedList.count == 0 {
            feedTableView.separatorStyle = .none
            feedTableView.backgroundView = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(identifier: "feedEmptyView").view as! UIView
        }else{
            feedTableView.separatorStyle = .singleLine
            feedTableView.separatorInset.left = 0
            feedTableView.backgroundView = nil
        }
        return feedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let length = 110
        let feed = feedList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            return UITableViewCell()
        }
        cell.feedCellDelegate = self
        cell.dateLabel.text = feed.postAt
        cell.bookTitleLabel.text = feed.title
        cell.bookAuthorLabel.text = feed.writer
        cell.percentLabel.text = "\(feed.percent)% 읽음"
        cell.timeLabel.text = "\(feed.time)분"
        
        if let profile = feed.profilePictureURL {
            let decodedData = NSData(base64Encoded: profile, options: [])
            if let data = decodedData {
                cell.profileImageView.image = UIImage(data: data as Data)
            }else{
                cell.profileImageView.image = UIImage(named: "defaultProfile")
            }
        }
        
        if let name = feed.name {
            cell.nameLabel.text = name
        }
        
        if let imageURL = feed.imageURL{
            let url = URL(string: imageURL)
            cell.bookImageView.kf.setImage(with: url, placeholder: UIImage(named: "defaultProfile"), options: nil, completionHandler: nil)
        }
        
        if feed.text.utf8.count <= length {
            cell.impressionLabel.numberOfLines = 0
            cell.impressionLabel.text = feed.text
            cell.moreButton.isHidden = true
        }else if expandedIndexSet.contains(indexPath.row) {
            cell.impressionLabel.numberOfLines = 0
            cell.textConstraint.constant = 0
            self.view.layoutIfNeeded()
            cell.impressionLabel.text = feed.text
            cell.moreButton.isHidden = true
        }else{
            cell.impressionLabel.numberOfLines = 2
            cell.impressionLabel.text = cell.impressionLabel.getTruncatingText(originalString: feed.text, newEllipsis: "..더보기", maxLines: 2)
            cell.moreButton.isHidden = false
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height: CGFloat = scrollView.frame.size.height
        let contentYOffset: CGFloat = scrollView.contentOffset.y
        let scrollViewHeight: CGFloat = scrollView.contentSize.height
        let distanceFromBottom: CGFloat = scrollViewHeight - contentYOffset
                  
        if distanceFromBottom < height && !isEnd && isLoaded {
            addData()
        }
    }
    
    func addData(){
        page+=5
        loadReviewData(page: page, limit: limit)
    }

}

extension CommunityViewController: FeedCellDelegate {
    func didTapMoreButton(cell: FeedCell) {
        if let indexPath = feedTableView.indexPath(for: cell) {
            print("more button tapped at row-\(String(indexPath.row))")
            expandedIndexSet.insert(indexPath.row)
            feedTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didTapEditButton(cell: FeedCell) {
        if let indexPath = feedTableView.indexPath(for: cell){
            showAlert(indexPath: indexPath)
        }
    }
    
    func showAlert(indexPath: IndexPath) { // alert 보여줄 때 breaking constraint는 버그라고 한다.
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modify = UIAlertAction(title: "수정", style: .default) { (action) in
            let vc = UIStoryboard(name: "Library", bundle: nil).instantiateViewController(identifier: "LibraryController") as! LibraryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let remove = UIAlertAction(title: "신고", style: .destructive) { (action) in
            let vc = UIStoryboard(name: "My", bundle: nil).instantiateViewController(identifier: "QuestionController") as! QuestionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(modify)
        alert.addAction(remove)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}


// API 호출 메소드
extension CommunityViewController {
    
    // 리뷰 조회 - 처음 화면 로드할 때
    private func loadReviewData(page: Int, limit: Int) {
        guard let token = Constants.KEYCHAIN_TOKEN else { return }
        Network.request(req: FeedRequest(token: token, page: page,limit: limit)) { result in
            switch result {
            case .success(let response):
                if response.code == 1000 {
                    self.isLoaded = true
                    if response.journalcount != 0 {
                        if response.journalcount < limit{
                            self.isEnd = true
                        }
                        guard let result = response.feed else { return }
                        DispatchQueue.main.async {
                            self.feedList.append(contentsOf: result)
                            self.feedTableView.reloadData()
                        }
                    }else{
                        self.isEnd = true
                    }
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
