//
//  BookSettingViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/25.
//

import UIKit
import Toast_Swift

// 메인 화면 하단 -> [책 관리] 버튼 터치시 나오는 VC
class BookSettingViewController: UIViewController {
    var books : [Book] = []
    let toastMessage = """
                        목록을 밀어서 도전할 책을
                        변경, 삭제할 수 있어요!
                       """
    @IBOutlet weak var readingBookTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.makeToast(toastMessage, duration: 2, position: .center, title: nil, image: nil, completion: nil)
    }
    
    func setupUI() {
        setNavBar()
        setTableView()
    }
    
    private func setTableView() {
        readingBookTableView.delegate = self
        readingBookTableView.dataSource = self
        readingBookTableView.register(UINib(nibName: ReadingBookTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ReadingBookTableViewCell.identifier)

    }
    
    private func setNavBar() {
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addBook(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .darkgrey
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }

    @objc func addBook(sender: UIBarButtonItem) {
        let searchBookVC = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(searchBookVC, animated: true)
    }


}

extension BookSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReadingBookTableViewCell.identifier, for: indexPath) as? ReadingBookTableViewCell
            else { return UITableViewCell() }
        cell.separatorInset = UIEdgeInsets.zero

        // 읽는 중인 책만 핑크색 인디케이터 색깔 추가
//        if indexPath.row == 2 {
//            cell.readingBookStatusView.backgroundColor = .sub2
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // 해당 책을 챌린지 책으로 수정(등록)
        let modifiyAction = UITableViewRowAction(style: .destructive, title: "도전하기") { _, _ in

        }

        // 해당 책을 읽는 책 리스트에서 삭제
        let deleteAction = UITableViewRowAction(style: .destructive, title: "삭제") { _, _ in

        }
        
        modifiyAction.backgroundColor = .darkgrey
        deleteAction.backgroundColor = .fillDisabled
        return [modifiyAction, deleteAction]
    }

}
