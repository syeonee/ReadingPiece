//
//  CreateReviewViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/10.
//

import UIKit

class CreateReviewViewController: UIViewController {
    
    let bookInfoCell = ReviewBookInfoCell()
    let ratingCell = ReviewRatingCell()
    let writingCell = ReviewWritingCell()
    
    var book : Book?
    var bookID: Int?
    
    // 리뷰 작성 버튼 활성화여부 체크
    var doneActivated: Bool = false {
        didSet {
            if doneActivated == true {
                doneButton.isEnabled = true
                doneButton.setImage(UIImage(named: "completeButton"), for: .normal)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.tintColor = .main
            } else {
                doneButton.isEnabled = false
                doneButton.setImage(UIImage(named: "completeButtonDisabled"), for: .normal)
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.tintColor = .darkgrey
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("bookID: \(String(describing: bookID))")
        setNavBar()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ReviewBookInfoCell", bundle: nil), forCellReuseIdentifier: bookInfoCell.cellID)
        tableView.register(UINib(nibName: "ReviewRatingCell", bundle: nil), forCellReuseIdentifier: ratingCell.cellID)
        tableView.register(UINib(nibName: "ReviewWritingCell", bundle: nil), forCellReuseIdentifier: writingCell.cellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        self.dismissKeyboardWhenTappedAround()
        doneActivated = false
    }
    
    
    private func setNavBar() {
        self.navigationItem.title = "평가/리뷰"
        self.navigationController?.navigationBar.topItem?.title = ""
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(postReview(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .darkgrey
        self.navigationController?.navigationBar.tintColor = .darkgrey
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    }
    
    @objc func postReview(sender: UIBarButtonItem) {
        postReview()
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        postReview()
    }
    
    private func didSuccessToPost() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension CreateReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: bookInfoCell.cellID) as! ReviewBookInfoCell
            let url = URL(string: book!.thumbnailPath)
            cell.coverImageView.kf.setImage(with: url)
            cell.titleLabel.text = book?.title
            cell.authorLabel.text = book?.authors.joined(separator: ",")
            cell.publisherLabel.text = book?.publisher
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ratingCell.cellID) as! ReviewRatingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: writingCell.cellID) as! ReviewWritingCell
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else if indexPath.row == 1{
            return 120
        } else {
            return 280
        }
    }
}

// 리뷰 작성 완료 버튼 관련 델리게이트
extension CreateReviewViewController: ReviewWritingCellDelegate {
    func activateDoneButton() {
        doneActivated = true
    }
}

// 리뷰생성 API 호출
extension CreateReviewViewController {
    private func postReview() {
        Network.request(req: PostReviewRequest(bookID: self.bookID!, star: ratingCell.starCount, text: writingCell.reviewInputTextView.text, isPublic: writingCell.isPublic!)) { result in
            switch result {
            case .success(let response):
                if response.code == 1000 {
                    self.didSuccessToPost()
                } else {
                    let message = response.message
                    self.presentAlert(title: message)
                }
                print(response)
            case .cancel(let cancelError):
                print(cancelError as Any)
            case .failure(let error):
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
                print(error?.localizedDescription as Any)
            }
        }
    }
}
