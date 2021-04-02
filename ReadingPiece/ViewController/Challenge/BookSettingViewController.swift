//
//  BookSettingViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/25.
//

import UIKit
import KeychainSwift

// 메인 화면 하단 -> [책 관리] 버튼 터치시 나오는 VC
class BookSettingViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    let goalBookId = UserDefaults.standard.integer(forKey: Constants.USERDEFAULT_KEY_GOAL_BOOK_ID)
    @IBOutlet weak var readingBookTableView: UITableView!
    var books : [AllReadingBook] = [] {
        didSet{
            readingBookTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "책 관리"
        setupUI()
        getAllBooks()
        view.makeToast("목록을 밀어서 도전할 책을\n변경, 삭제할수 있어요!", duration: 2, position: .center, title: nil, image: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    func getAllBooks() {
        guard let token = keychain.get(Keys.token) else { return }
        let req = GetAllReadingBookRequest(token: token)
        _ = Network.request(req: req) { (result) in
                switch result {
                case .success(let userResponse):
                    switch userResponse.code {
                    case 1000:
                        print("LOG - 책 정보 조회 성공", userResponse.getbookListRows as Any)
                        guard let books = userResponse.getbookListRows else { return }
                        self.books = books
                    case 2221:
                        print("LOG - 챌린지 진행 전", userResponse.message)
                        self.presentAlert(title: "메인화면에서 먼저 목표를 추가해주세요.", isCancelActionIncluded: false)
                    case 2222:
                        print("LOG - 챌린지 진행 전", userResponse.message)
                        self.presentAlert(title: "도전할 책을 먼저 추가해주세요.", isCancelActionIncluded: false)
                    default:
                        self.presentAlert(title: "도전중인 책 정보가 없습니다.", isCancelActionIncluded: false)
                    }
                case .cancel(let cancelError):
                    print(cancelError!)
                case .failure(let error):
                    debugPrint("LOG -", error as Any)
                    self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false)
            }
        }
    }
    
    func setupUI() {
        setNavBar()
        setTableView()
    }
    
    private func setTableView() {
        readingBookTableView.delegate = self
        readingBookTableView.dataSource = self
        readingBookTableView.register(UINib(nibName: ReadingBookTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ReadingBookTableViewCell.identifier)
        readingBookTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setNavBar() {
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addBook(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .melon
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }

    @objc func addBook(sender: UIBarButtonItem) {
        let searchBookVC = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        searchBookVC.initializer = 2
        self.navigationController?.pushViewController(searchBookVC, animated: true)
    }

    // 읽고있는 책 중에 특정 책 하나를 도전중인 책으로 변경
    func modifiyChallengeBook(id: Int) {
        guard let token = keychain.get(Keys.token) else { return }

        let req = PatchChallengeBookRequest(token: token, goalbookId: goalBookId)
        _ = Network.request(req: req) { (result) in
                switch result {
                case .success(let userResponse):
                    switch userResponse.code {
                    case 1000:
                        print("LOG = 도전 책 수정 완료", userResponse.message, userResponse.code)
                        self.getAllBooks()
                        self.readingBookTableView.reloadData()
                        self.navigationController?.popViewController(animated: true)
                    case 2225, 4000 :
                        self.presentAlert(title: "이미 읽고있는 책이네요! 다른 책을 골라주세요.", isCancelActionIncluded: false)
                    case 2223:
                        self.presentAlert(title: "도전할 책을 먼저 추가해주세요.", isCancelActionIncluded: false)
                    default:
                        self.presentAlert(title: "유효하지 않은 로그인 정보", isCancelActionIncluded: false)
                    }
                case .cancel(let cancelError):
                    print(cancelError!)
                case .failure(let error):
                    debugPrint("LOG", error)
                    self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false)
            }
        }
    }
    
    // 읽고있는 책 삭제
    func deleteChallengeBook(id: Int) {
        guard let token = keychain.get(Keys.token) else { return }
        let req = DeleteChallengeBookRequest(token: token, goalbookId: id)
        _ = Network.request(req: req) { (result) in
                switch result {
                case .success(let userResponse):
                    switch userResponse.code {
                    case 1000, 2201:
                        print("LOG - 책 삭제 성공")
                        self.getAllBooks()
                        self.readingBookTableView.reloadData()
                    case 4000:
                        self.presentAlert(title: "읽고 있는 책은 1권 이상이여야 합니다.", isCancelActionIncluded: false)
                    default:
                        print(userResponse.message, userResponse.code)
                        self.presentAlert(title: "책 삭제 실패! 로그인 정보를 확인해주세요.", isCancelActionIncluded: false)
                    }
                case .cancel(let cancelError):
                    print(cancelError!)
                case .failure(let error):
                    debugPrint("LOG", error)
                    self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false)
            }
        }
    }

}

extension BookSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = books.count
        if count == 0 {
            let message = "아직 추가한 책이 없어요. "
            readingBookTableView.setEmptyView(image: UIImage(named: "recordIcon")!, message: message, buttonType: "메인으로 가기", actionButtonClosure: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        } else {
            readingBookTableView.restoreWithLine()
        }
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReadingBookTableViewCell.identifier, for: indexPath) as? ReadingBookTableViewCell
            else { return UITableViewCell() }
        cell.configure(bookData: books[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // 해당 책을 챌린지 책으로 수정(등록)
        let modifiyAction = UITableViewRowAction(style: .destructive, title: "도전하기") { _, _ in
            let goalBookId = self.books[indexPath.row].goalBookId
            print("책 수정 완료 - goalBookId : \(goalBookId)")
            self.modifiyChallengeBook(id: goalBookId)
        }

        // 해당 책을 읽는 책 리스트에서 삭제
        let deleteAction = UITableViewRowAction(style: .destructive, title: "삭제") { _, _ in
            self.deleteChallengeBook(id: self.books[indexPath.row].goalBookId)
        }
        
        modifiyAction.backgroundColor = .darkGray
        deleteAction.backgroundColor = .disabled2
        return [deleteAction, modifiyAction]
    }
    
}
