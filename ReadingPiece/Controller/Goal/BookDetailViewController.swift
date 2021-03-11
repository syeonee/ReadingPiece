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
 
        return cell
    }
    
    
}
