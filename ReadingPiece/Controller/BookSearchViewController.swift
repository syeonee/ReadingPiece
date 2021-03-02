//
//  BookSearchViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/25.
//

import UIKit

class BookSearchViewController: UIViewController, UITextFieldDelegate {

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
