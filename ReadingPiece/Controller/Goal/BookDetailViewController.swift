//
//  BookDetailViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/08.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var initializer: Int?

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var reviewTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    var isExpanded : Bool = false
    var observerExist : Bool = false
    
    var initHeight : NSLayoutConstraint?
    var book : Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.separatorStyle = .none
        reviewTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "bookReviewCell")
        reviewTableView.rowHeight = 189.5
        
        reviewTableView.estimatedRowHeight = 189.5
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if observerExist {
            reviewTableView.removeObserver(self, forKeyPath: "contentSize")
            observerExist = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey]{
                    let newSize = newValue as! CGSize
                    reviewTableViewHeight.constant = newSize.width
                    
                }
            }
        }
    }
    
    func setUI(){
        let url = URL(string: book!.thumbnailPath)
        bookImageView.kf.setImage(with: url)
        titleLabel.text = book?.title
        authorsLabel.text = book?.authors.joined(separator: ",")
        publisherLabel.text = book?.publisher
        summaryLabel.text = book?.summary
    }
    
    @IBAction func moreReviewTapped(_ sender: Any) {
        
    }
    
    @IBAction func addBook(_ sender: Any) {
        guard let initNumber = self.initializer else { return }
        // initializer가 0이면 목표 설정에서 호출, 책추가 버튼 누르면 메인 탭 바 컨트롤러로 이동
        // initializer가 1이면 내서재 리뷰쓰기 화면에서 호출, 책추가 버튼 누르면 리뷰 작성 화면으로 이동
        
        if initNumber == 0 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabController") as! UITabBarController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        } else if initNumber == 1 {
            let reviewVC = CreateReviewViewController()
            reviewVC.book = self.book
            self.navigationController?.pushViewController(reviewVC, animated: true)
        }
        
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
        
        cell.reviewCellDelegate = self
        
        if isExpanded {// 더보기 버튼을 누른 셀인 경우
            print("is Expand")
            cell.reviewLabel.numberOfLines = 0
            cell.moreReadButton.isHidden = true
        } else {
            cell.reviewLabel.numberOfLines = 2
            cell.moreReadButton.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension BookDetailViewController: ReviewTableViewCellDelegate {
    func moreTextButtonTapped(cell: ReviewTableViewCell) {
        if let indexPath = reviewTableView.indexPath(for: cell) {
            print("more button tapped at row-\(String(indexPath.row))")
            isExpanded = true
            reviewTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)//테이블 뷰 높이 바꾸기 위해서
            observerExist = true
            reviewTableView.reloadData()
        }
    }
    
    func editReviewButtonTapped(cell: ReviewTableViewCell) {
        if let indexPath = reviewTableView.indexPath(for: cell){
            showAlert(indexPath: indexPath)
        }
    }
    
    func likeButtonTapped(cell: ReviewTableViewCell) {
        if let indexPath = reviewTableView.indexPath(for: cell) {
            print("like button tapped at row-\(String(indexPath.row))")
            if let cell = reviewTableView.cellForRow(at: indexPath) as? ReviewTableViewCell {
                if cell.likeButton.isSelected { // 좋아요 누른 경우
                    
                } else { // 좋아요 안누른 경우
                    
                }
                cell.likeButton.isSelected = !cell.likeButton.isSelected
            }
        }
    }
    
    func commentButtonTapped(cell: ReviewTableViewCell) {
        if let indexPath = reviewTableView.indexPath(for: cell) {
            print("comment button tapped at row-\(String(indexPath.row))")
            let storyboard = UIStoryboard(name: "Goal", bundle: nil)
            if let myViewController = storyboard.instantiateViewController(withIdentifier: "CommentController") as? CommentViewController {
                presentPanModal(myViewController)
            }
        }
    }
    
    func showAlert(indexPath: IndexPath) { // alert 보여줄 때 breaking constraint는 버그라고 한다.
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modify = UIAlertAction(title: "수정", style: .default) { (action) in
            print("리뷰 수정 row-\(indexPath.row)")
        }
        let remove = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            print("리뷰 삭제 row-\(indexPath.row)")
            //TODO : 데이터 삭제
            //self.reviewTableView.deleteRows(at: [indexPath], with: .automatic)//삭제 후 다른 사람의 리뷰로 대체??
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(modify)
        alert.addAction(remove)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
