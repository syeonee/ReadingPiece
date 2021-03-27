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
    
    // 리뷰 생성할때 쓰이는 변수
    var book : Book?
    var bookID: Int?
    
    // 리뷰 수정할 때 쓰이는 변수
    var reviewID: Int?
    var thumbnail: String?
    var bookTitle: String?
    var author: String?
    var publisher: String?
    var starCount: Double?
    var reviewText: String?
    var isPublic: Int?
    
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
        print("bookID: \(String(describing: self.bookID))")
        
        // 리뷰 수정일 경우 기존 데이터 불러오기
        if let reviewID = self.reviewID {
            print("리뷰 수정 중")
            getReview(reviewID: reviewID)
        }
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
        if let bookID = self.bookID {
            postReview(bookID: bookID)
        } else if let reviewID = self.reviewID {
            patchReview(reviewID: reviewID)
        } else {
            self.presentAlert(title: "리뷰가 정상적으로 처리되지 않았습니다. ", isCancelActionIncluded: false, handler: {_ in
                self.navigationController?.popToRootViewController(animated: true)
            })
            
        }
        
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        if let bookID = self.bookID {
            postReview(bookID: bookID)
        } else if let reviewID = self.reviewID {
            patchReview(reviewID: reviewID)
        } else {
            self.presentAlert(title: "리뷰가 정상적으로 처리되지 않았습니다. ", isCancelActionIncluded: false, handler: {_ in
                self.navigationController?.popToRootViewController(animated: true)
            })
            
        }
    }
    
    private func didSuccessToPost() {
        self.presentAlert(title: "리뷰 작성이 완료되었습니다. ", isCancelActionIncluded: false) {_ in
            NotificationCenter.default.post(name: Notification.Name("GetReviewData"), object: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func didSuccessToPatch() {
        self.presentAlert(title: "리뷰 수정이 완료되었습니다. ", isCancelActionIncluded: false) {_ in
            NotificationCenter.default.post(name: Notification.Name("GetReviewData"), object: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

extension CreateReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: bookInfoCell.cellID) as! ReviewBookInfoCell
            
            if let thumbnail = self.thumbnail {
                let url = URL(string: thumbnail)
                cell.coverImageView.kf.setImage(with: url)
            } else {
                if let thumbnailPath = book?.thumbnailPath {
                    let url = URL(string: thumbnailPath)
                    cell.coverImageView.kf.setImage(with: url)
                } else {
                    cell.coverImageView.image = UIImage(named: "Book_icon")
                }
            }
            
            if let title = self.bookTitle {
                cell.titleLabel.text = title
            } else {
                cell.titleLabel.text = book?.title
            }
            if let author = self.author {
                cell.authorLabel.text = author
            } else {
                cell.authorLabel.text = book?.authors.joined(separator: ",")
            }
            if let publisher = self.publisher {
                cell.publisherLabel.text = publisher
            } else {
                cell.publisherLabel.text = book?.publisher
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ratingCell.cellID) as! ReviewRatingCell
            if let count = self.starCount {
                cell.starCount = count
            }
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: writingCell.cellID) as! ReviewWritingCell
            if let text = self.reviewText {
                cell.reviewInputTextView.text = text
            }
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
extension CreateReviewViewController: ReviewWritingCellDelegate, ReviewRatingCellDelegate {
    func getRatingData(star: Double) {
        self.starCount = star
    }
    
    func activateDoneButton(text: String, isPublic: Int) {
        doneActivated = true
        self.reviewText = text
        self.isPublic = isPublic
    }
}

// 리뷰생성 API 호출
extension CreateReviewViewController {
    private func postReview(bookID: Int) {
        Network.request(req: PostReviewRequest(bookID: bookID, star: Int(self.starCount ?? 0), text: self.reviewText ?? "", isPublic: self.isPublic ?? 1)) { result in
            switch result {
            case .success(let response):
                if response.code == 1000 {
                    self.didSuccessToPost()
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
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
    
    private func getReview(reviewID: Int) {
        Network.request(req: GetReviewEditRequest(reviewID: reviewID)) { result in
            switch result {
            case .success(let response):
                if response.code == 1000 {
                    let result = response.result
                    //print(result)
                    self.bookTitle = result.title
                    self.author = result.writer
                    self.publisher = result.publisher
                    self.thumbnail = result.imageURL
                    self.starCount = Double(result.star)
                    self.reviewText = result.text
                    DispatchQueue.main.async {
                        //self.presentAlert(title: "데이터 GET 완료 - 화면 준비")
                        self.tableView.reloadData()
                    }
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
                }
            case .cancel(let cancel):
                print(cancel as Any)
            case .failure(let error):
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    private func patchReview(reviewID: Int) {
        print("patch review here")
        Network.request(req: PatchReviewRequest(reviewID: reviewID, star: Int(self.starCount ?? 0), text: self.reviewText ?? "", isPublic: self.isPublic ?? 1)) { result in
            switch result {
            case .success(let response):
                print(response)
                if response.code == 1000 {
                    self.didSuccessToPatch()
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
                }
            case .cancel(let cancel):
                print(cancel as Any)
            case .failure(let error):
                print(error?.localizedDescription as Any)
            }
        }
    }
}
