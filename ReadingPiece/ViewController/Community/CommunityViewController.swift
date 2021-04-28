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

    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    var page : Int = 0
    let limit : Int = 5
    var isEnd : Bool = false
    var isLoaded : Bool = false
    var isRefresh : Bool = false
    
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.backgroundColor = .white
        loadReviewData(page: 0, limit: limit)
        feedTableView.alwaysBounceVertical = true
        initRefresh()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCell")
        
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.estimatedRowHeight = 284
        indicator.center = self.view.center
    }
    
    func initRefresh(){
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        feedTableView.addSubview(refresh)
    }
    
    @objc func updateUI(refresh: UIRefreshControl){
        refresh.endRefreshing()
        page = 0
        isEnd = false
        isLoaded = false
        isRefresh = true
        feedList = []
        expandedIndexSet = []
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
        
        if feed.profilePictureURL != nil{
            let decodedData = NSData(base64Encoded: feed.profilePictureURL ?? "", options: [])
            if let data = decodedData {
                if data.count < 2 {
                    cell.profileImageView.image = UIImage(named: "profile_basic_photo2")
                } else {
                    cell.profileImageView.image = UIImage(data: data as Data)
                }
            }else{
                cell.profileImageView.image = UIImage(named: "profile_basic_photo2")
            }
        }else{
            cell.profileImageView.image = UIImage(named: "profile_basic_photo2")
        }
        
        if feed.status == "N"{
            cell.statusImageView.image = UIImage(named: "readOngoing")
        }else{
            cell.statusImageView.image = UIImage(named: "feedComplete")
        }
        
        if let name = feed.name {
            cell.nameLabel.text = name
        }else{
            cell.nameLabel.text = "Reader\(feed.userId)"
        }
        
        if let imageURL = feed.imageURL{
            let url = URL(string: imageURL)
            cell.bookImageView.kf.setImage(with: url, placeholder: UIImage(named: "defaultBookCoverImage"), options: nil, completionHandler: nil)
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
//        let modify = UIAlertAction(title: "수정", style: .default) { (action) in
//            let vc = UIStoryboard(name: "Library", bundle: nil).instantiateViewController(identifier: "LibraryController") as! LibraryViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        let remove = UIAlertAction(title: "신고", style: .destructive) { (action) in
            let vc = UIStoryboard(name: "My", bundle: nil).instantiateViewController(identifier: "QuestionController") as! QuestionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
//        alert.addAction(modify)
        alert.addAction(remove)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}


// API 호출 메소드
extension CommunityViewController {
    
    // 리뷰 조회 - 처음 화면 로드할 때
    private func loadReviewData(page: Int, limit: Int) {
        if !isLoaded && !isRefresh{//처음 로드 할 때만 인디케이터 보여주기
            indicator.startAnimating()
        }
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: FeedRequest(token: token, page: page,limit: limit)) { result in
            switch result {
            case .success(let response):
                if response.code == 1000 {
                    self.isLoaded = true
                    self.isRefresh = false
                    if response.journalcount != 0 {
                        if response.journalcount < limit{
                            self.isEnd = true
                        }
                        guard let result = response.feed else { return }
                        DispatchQueue.main.async {
                            self.feedList.append(contentsOf: result)
                            self.feedTableView.reloadData()
                            if self.indicator.isAnimating {
                                self.indicator.stopAnimating()
                            }
                        }
                    }else{
                        self.isEnd = true
                        self.isRefresh = false
                    }
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        if self.indicator.isAnimating {
                            self.indicator.stopAnimating()
                        }
                        self.presentAlert(title: message)
                    }
                }
            case .cancel(let cancel):
                self.isRefresh = false
                if self.indicator.isAnimating {
                    self.indicator.stopAnimating()
                }
                print(cancel as Any)
            case .failure(let error):
                self.isRefresh = false
                if self.indicator.isAnimating {
                    self.indicator.stopAnimating()
                }
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
                print(error as Any)
            }
        }
    }
}
