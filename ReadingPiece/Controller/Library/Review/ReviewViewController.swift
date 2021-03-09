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
    var reviews = [
        Review(thumbnailImage: UIImage(named: "bookCoverImage1")!, bookTitle: "달러구트 꿈 백화점", author: "이미예", rating: "4.0", reviewText: "달러구트 꿈 백화점은 우리에게 또다른 세상을 보여준다. 우리가 전혀 알지 못했던 사실을 익숙하면서도", date: Date()),
        Review(thumbnailImage: UIImage(named: "bookCoverImage2")!, bookTitle: "나의 첫 투자수업", author: "김정환", rating: "3.0", reviewText: "최근 주식 투자에 대한 열풍이 불면서 시중에 엄청나게 많은 정보가 쏟아지고 있습니다. 그중에는 잘못된 정보도 많고 개인들이 이해하기 쉽지 않은 내용도 많습니다. 이 책은 개인 투자자가 어떻게 산업과 기업을 분석하고 공부해야하는지 그리고 실전에서의 투자는 어떻게 진행되어야 하는지 구체적이고 자세한 설명이 적혀있습니다. 투자에 관심이 있다면 꼭! 읽어보기를 권하는 책입니다.", date: Date(timeIntervalSinceNow: 10)),
        Review(thumbnailImage: UIImage(named: "bookCoverImage3")!, bookTitle: "보건교사 안은영", author: "정세랑", rating: "2.0", reviewText: "예측할 수 없는 존재들과 사건들의 등장으로 나의 상상력을 극대화 시켜주는 책이다. 젤리괴물들의 모습과 안은영이 젤리괴물들을 무기들 등 이미지를 상상하며 즐거웠다. 등장인물들 각각의 캐릭터 또한 두드러져 한 명 한 명의 실제 모습을 상상해보는 것도 재미있었다.", date: Date(timeIntervalSinceNow: 20)),
        Review(thumbnailImage: UIImage(named: "bookCoverImage4")!, bookTitle: "빌 게이츠, 기후 재앙을 피하는 법", author: "빌 게이츠", rating: "4.0", reviewText: "이 책의 제목처럼, 기후 재앙을 피하기 위해서 우리는 한 가지 목표를 반드시 달성해야 한다고 빌게이츠는 말한다. 현재 인류가 매년 만들어내는 온실가스는 510억 톤이다. 2050년까지 인류는 온실가스 배출양을 510억 톤에서 0으로 만들어야 한다. 그래야만 우리는 끔찍한 기후 재앙으로부터 멀어질 수 있다. ", date: Date(timeIntervalSinceNow: 30)),
        Review(thumbnailImage: UIImage(named: "bookCoverImage5")!, bookTitle: "빌 게이츠, 기후 재앙을 피하는 법", author: "빌 게이츠", rating: "5.0", reviewText: "탄소 배출을 제로로 갈 수 있는 다양한 길과 여정을 살펴보고 우리가 어떻게 할 수 있는지를 밝히는 책", date: Date(timeIntervalSinceNow: 40)),
        Review(thumbnailImage: UIImage(named: "bookCoverImage1")!, bookTitle: "달러구트 꿈 백화점", author: "이미예", rating: "4.0", reviewText: "달러구트 꿈 백화점은 우리에게 또다른 세상을 보여준다. 우리가 전혀 알지 못했던 사실을 익숙하면서도", date: Date(timeIntervalSinceNow: 50)),
        Review(thumbnailImage: UIImage(named: "bookCoverImage2")!, bookTitle: "나의 첫 투자수업", author: "김정환", rating: "3.0", reviewText: "최근 주식 투자에 대한 열풍이 불면서 시중에 엄청나게 많은 정보가 쏟아지고 있습니다. 그중에는 잘못된 정보도 많고 개인들이 이해하기 쉽지 않은 내용도 많습니다. 이 책은 개인 투자자가 어떻게 산업과 기업을 분석하고 공부해야하는지 그리고 실전에서의 투자는 어떻게 진행되어야 하는지 구체적이고 자세한 설명이 적혀있습니다. 투자에 관심이 있다면 꼭! 읽어보기를 권하는 책입니다.", date: Date(timeIntervalSinceNow: 60)),
        Review(thumbnailImage: UIImage(named: "bookCoverImage3")!, bookTitle: "보건교사 안은영", author: "정세랑", rating: "4.0", reviewText: "예측할 수 없는 존재들과 사건들의 등장으로 나의 상상력을 극대화 시켜주는 책이다. 젤리괴물들의 모습과 안은영이 젤리괴물들을 무기들 등 이미지를 상상하며 즐거웠다. 등장인물들 각각의 캐릭터 또한 두드러져 한 명 한 명의 실제 모습을 상상해보는 것도 재미있었다.", date: Date(timeIntervalSinceNow: 70)),
        Review(thumbnailImage: UIImage(named: "bookCoverImage4")!, bookTitle: "빌 게이츠, 기후 재앙을 피하는 법", author: "빌 게이츠", rating: "1.0", reviewText: "이 책의 제목처럼, 기후 재앙을 피하기 위해서 우리는 한 가지 목표를 반드시 달성해야 한다고 빌게이츠는 말한다. 현재 인류가 매년 만들어내는 온실가스는 510억 톤이다. 2050년까지 인류는 온실가스 배출양을 510억 톤에서 0으로 만들어야 한다. 그래야만 우리는 끔찍한 기후 재앙으로부터 멀어질 수 있다. ", date: Date(timeIntervalSinceNow: 80)),
        Review(thumbnailImage: UIImage(named: "bookCoverImage5")!, bookTitle: "빌 게이츠, 기후 재앙을 피하는 법", author: "빌 게이츠", rating: "5.0", reviewText: "탄소 배출을 제로로 갈 수 있는 다양한 길과 여정을 살펴보고 우리가 어떻게 할 수 있는지를 밝히는 책", date: Date(timeIntervalSinceNow: 90))
    ]
    
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
        self.more = Array<Int>(repeating: 0, count: reviews.count)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let length = self.reviews[0].reviewText.utf8.count
        
        if self.reviews[indexPath.row].reviewText.utf8.count <= length {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
            let review = self.reviews[indexPath.row]
            cell.bookImageView.image = review.thumbnailImage
            cell.bookTitleLabel.text = review.bookTitle
            cell.authorLabel.text = review.author
            cell.ratingLabel.text = review.rating
            cell.reviewTextLabel.text = review.reviewText
            
            cell.editDelegate = self
            return cell
        } else if more[indexPath.row] == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCell.cellID) as! ReviewCell
            let review = self.reviews[indexPath.row]
            cell.bookImageView.image = review.thumbnailImage
            cell.bookTitleLabel.text = review.bookTitle
            cell.authorLabel.text = review.author
            cell.ratingLabel.text = review.rating
            cell.reviewTextLabel.text = String(review.reviewText.prefix(60))
            
            cell.moreDelegate = self
            cell.editDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
            let review = self.reviews[indexPath.row]
            cell.bookImageView.image = review.thumbnailImage
            cell.bookTitleLabel.text = review.bookTitle
            cell.authorLabel.text = review.author
            cell.ratingLabel.text = review.rating
            cell.reviewTextLabel.text = review.reviewText
            
            cell.editDelegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerView.identifier) as! ReviewHeaderCell
        cell.count.text = String(self.reviews.count)
        cell.recentDelegate = self
        cell.oldDelegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
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
    func didTapMoreButton(cell: ReviewCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        print("ReviewViewController - didTapMoreButton() called. indexPath: \(String(describing: indexPath))")
        self.more[indexPath![1]] = 1
        
        self.tableView.reloadRows(at: [IndexPath(row: indexPath![1], section: 0)], with: .fade)
    }
    
}

// 수정 버튼 관련 메소드
extension ReviewViewController: ReviewEditDelegate, ReviewFullEditDelegate {
    func didTapFullEditButton(cell: FullReviewCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        print("ReviewViewController - didTapFullEditButton() called. indexPath: \(String(describing: indexPath))")
        showAlert(indexPath: indexPath!)
    }
    
    func didTapEditButton(cell: ReviewCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        print("ReviewViewController - didTapEditButton() called. indexPath: \(String(describing: indexPath))")
        showAlert(indexPath: indexPath!)
    }
    
    func showAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let success = UIAlertAction(title: "수정", style: .default) { (action) in
            print("수정하기")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            self.reviews.remove(at: indexPath[1])
            self.tableView.deleteRows(at: [IndexPath(row: indexPath[1], section: 0)], with: .left)
            self.tableView.reloadData()  // 섹션 헤더 reload 위해 사용
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        alert.addAction(destructive)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// 정렬 관련 메소드
extension ReviewViewController: ReviewLatestDelegate, ReviewOldestDelegate {
    func sortRecentFirst() {
        print("ReviewViewController - sortRecentFirst() called")
        reviews.sort(by: { $0.date > $1.date })
        tableView.reloadData()
    }
    
    func sortOldFirst() {
        print("ReviewViewController - sortOldFirst() called")
        reviews.sort(by: { $0.date < $1.date })
        tableView.reloadData()
    }
}
