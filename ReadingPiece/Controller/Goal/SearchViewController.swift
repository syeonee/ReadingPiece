//
//  SearchViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/05.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.delegate = self
        
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
        print(searchTextField.text)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookCell else {
            return UITableViewCell()
        }
        
        cell.bookImageView.image = UIImage(named: "안은영")
        cell.titleLabel.text = "보건교사 안은영"
        cell.authorLabel.text = "정세랑"
        cell.publisherLabel.text = "민음사"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index = \(indexPath.row)")
    }
    
}

class BookCell: UITableViewCell {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
}
