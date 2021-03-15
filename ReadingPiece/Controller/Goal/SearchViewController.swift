//
//  SearchViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/05.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    // SearchViewController가 어디서 호출되었는지 Int 값으로 전달하는 변수입니다
    // initializer가 0이면 목표 설정에서 호출, 책추가 버튼 누르면 메인 탭 바 컨트롤러로 이동
    // initializer가 1이면 내서재 리뷰쓰기 화면에서 호출, 책추가 버튼 누르면 리뷰 작성 화면으로 이동
    var initializer: Int?

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultCountLabel: UILabel!
    
    @IBOutlet weak var resultTableView: UITableView!
    
    var books : [Book] = []
    var page : Int = 1
    var resultCount : Int = 0
    var isEnd : Bool = true
    
    var searchTerm : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("initializer: \(String(describing: self.initializer))")
        self.searchTextField.delegate = self
        resultTableView.separatorInset.left = 20
        resultTableView.separatorInset.right = 20
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField { // 키보드에서 '검색' 버튼 눌러서 검색할 수 있도록 처리
            textField.resignFirstResponder()//
            bookSearch(searchButton!)
        }
        return true
    }
    
    @IBAction func removeText(_ sender: Any) { // 취소 버튼 눌렀을 때 텍스트 초기화
        searchTextField.text = ""
    }
    
    @IBAction func bookSearch(_ sender: Any) {
        searchTextField.resignFirstResponder()//검색 아이콘 누르면 키보드 내려가도록
        guard let term = searchTextField.text, term.isEmpty == false else { return }
        page = 1
        searchTerm = term
        NetworkAPI.search(query: searchTerm, page: page) { books, resultCount, isEnd in
            DispatchQueue.main.async {
                self.books = books
                self.resultCount = resultCount
                self.isEnd = isEnd
                self.resultCountLabel.text = "총 \(self.resultCount)권의 검색 결과"
                self.resultTableView.reloadData()
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookCell else {
            return UITableViewCell()
        }
        let book = books[indexPath.item]
        let url = URL(string: book.thumbnailPath)
        cell.bookImageView.kf.setImage(with: url)
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.authors.joined(separator: ",")
        cell.publisherLabel.text = book.publisher
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.item]
        
        let sb = UIStoryboard(name: "Goal", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "BookDetailController") as! BookDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.initializer = self.initializer
        vc.book = book
        self.navigationController?.pushViewController(vc, animated: true)
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
        NetworkAPI.search(query: searchTerm, page: page) { books, resultCount, isEnd in
            DispatchQueue.main.async {
                self.books.append(contentsOf: books)
                self.isEnd = isEnd
                self.resultTableView.reloadData()
            }
        }
    }
    
}

class BookCell: UITableViewCell {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
}
