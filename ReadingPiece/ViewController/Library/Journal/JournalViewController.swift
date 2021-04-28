//
//  JournalViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/04.
//

import UIKit
import KeychainSwift

class JournalViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    let journalCell = JournalCell()
    let fullJournalCell = FullJournalCell()
    let headerView = JournalHeaderCell()
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "y.MM.dd"
        return f
    } ()
    
    // 일지 리스트
    var journalList = [GetJournalResponseResult]()
    var journalCount: Int? // 일지 수
    var page : Int = 0 // 페이지 넘버
    var isEnd : Bool = false  // 마지막 페이지인지 체크하는 flag
    var align: String = "desc"  // 정렬 기준 나타내는 flag
    
    // 더보기 기능을 위한 0 또는 1 값을 저장하기 위한 Array
    var more: [Int] = []
    

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getJournalData(align: align, page: page, limit: 5)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadJournalData), name: Notification.Name("FetchJournalData"), object: nil)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "JournalCell", bundle: nil), forCellReuseIdentifier: journalCell.cellID)
        tableView.register(UINib(nibName: "FullJournalCell", bundle: nil), forCellReuseIdentifier: fullJournalCell.cellID)
        tableView.register(UINib(nibName: "JournalHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: headerView.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = .none
        tableView.backgroundColor = .lightgrey2
        
    }
    
    func didRetrieveData() {
        self.more = Array<Int>(repeating: 0, count: journalList.count)  // 더보기 값 배열 초기화
        self.tableView.reloadData() {
            self.tableView.scroll(to: .top, animated: true) // 처음 로드되거나 정렬기준을 바꿀 경우 스크롤위치 상단으로 이동
        }
    }
    func didRetrieveMoreData() {
        self.more = Array<Int>(repeating: 0, count: journalList.count)  // 더보기 값 배열 초기화
        self.tableView.reloadData() // 페이징으로 인한 추가 데이터 fetch 시에는 스크롤위치 변경하지 않음
    }
    
    @objc func reloadJournalData(notification: NSNotification) {
        getJournalData(align: align, page: page, limit: 5)
    }
    
    // 분 시간으로 바꾸기
    func convertToHourMinute(totalString: String) -> String {
        let total = Int(totalString)
        let hour = (total ?? 0) / 60
        let minute = (total ?? 0) % 60
        if hour == 0 {
            return "\(minute)분"
        }else if minute == 0{
            return "\(hour)시간"
        }
        return "\(hour)시간 \(minute)분"
    }
    
}

extension JournalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = journalList.count
        if count == 0 {
            let message = "아직 인증이 없어요. \n매일 독서 시간과 소감을 기록하고 \n챌린지를 달성해요!"
            tableView.setEmptyView(image: UIImage(named: "recordIcon")!, message: message, buttonType: "journal") {
                self.buttonAction()
            }
        } else {
            tableView.restoreWithoutLine()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let length = 110
        if journalList[indexPath.row].text.utf8.count <= length {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullJournalCell.cellID) as! FullJournalCell
            let journal = journalList[indexPath.row]
            cell.bookTitleLabel.text = journal.title
            cell.journalTextLabel.text = journal.text
            cell.dateLabel.text = journal.postAt
            
            cell.readingPercentageLabel.text = "\(journal.percent)% 읽음"
            cell.readingTimeLabel.text = convertToHourMinute(totalString: String(journal.time))
            cell.index = indexPath.row
            cell.editDelegate = self
            return cell
        } else if more[indexPath.row] == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: journalCell.cellID) as! JournalCell
            let journal = journalList[indexPath.row]
            cell.bookTitleLabel.text = journal.title
            cell.journalTextLabel.text = journal.text
            cell.dateLabel.text = journal.postAt
            
            cell.readingPercentLabel.text = "\(journal.percent)% 읽음"
            cell.readingTimeLabel.text = convertToHourMinute(totalString: String(journal.time))
            cell.index = indexPath.row
            cell.moreDelegate = self
            cell.editDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullJournalCell.cellID) as! FullJournalCell
            let journal = journalList[indexPath.row]
            cell.bookTitleLabel.text = journal.title
            cell.journalTextLabel.text = journal.text
            cell.dateLabel.text = journal.postAt
            
            cell.readingPercentageLabel.text = "\(journal.percent)% 읽음"
            cell.readingTimeLabel.text = convertToHourMinute(totalString: String(journal.time))
            cell.index = indexPath.row
            cell.editDelegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if journalList.count == 0 {
            return nil
        } else {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerView.identifier) as! JournalHeaderCell
            if let count = self.journalCount {
                cell.count.text = String(count)
            }
            cell.recentDelegate = self
            cell.oldDelegate = self
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if journalList.count == 0 {
            return 0
        } else {
            return 45
        }
    }
}

// Paging
extension JournalViewController {
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
        print("addData() called")
        page += 5
        getMoreJournal(align: align, page: page, limit: 5)
    }
}

// 더보기 기능 관련
extension JournalViewController: JournalMoreDelegate {
    func didTapMoreButton(index: Int) {
        self.more[index] = 1
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

// 수정 기능 관련
extension JournalViewController: JournalEditDelegate, FullJournalEditDelegate {
    func didTapEditButton(index: Int) {
        showAlert(index: index)
    }
    
    func didTapFullEditButton(index: Int) {
        showAlert(index: index)
    }
    
    func showAlert(index: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            // 일지 삭제 api 호출
            print("일지 삭제 요청중 - journalID: \(self.journalList[index].journalID)")
            self.deleteJournal(journalID: self.journalList[index].journalID, index: index)
        }
        
        alert.addAction(cancel)
        alert.addAction(destructive)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func didDeleteData(index: Int) {
        self.presentAlert(title: "일지가 삭제되었습니다. ", isCancelActionIncluded: false)
        self.journalList.remove(at: index)
        self.more.remove(at: index)
        self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        self.tableView.reloadData()  // 섹션 헤더 reload 위해 사용
    }
}

// 정렬 기능
extension JournalViewController: JournalOldestDelegate, JournalLatestDelegate {
    func sortOldFirst() {
        self.align = "asc"
        self.page = 0
        self.isEnd = false
        self.journalList = [] // 초기화
        getJournalData(align: align, page: page, limit: 5)
    }
    
    func sortRecentFirst() {
        self.align = "desc"
        self.page = 0
        self.isEnd = false
        self.journalList = [] // 초기화
        getJournalData(align: align, page: page, limit: 5)
    }
}

// 데이터가 없을 경우 표시되는 Placeholder
extension JournalViewController {
    
    func buttonAction () {
        self.tabBarController?.selectedIndex = 0
    }
}


// API 연동 메소드
extension JournalViewController {
    // 내가 쓴 일지 조회
    private func getJournalData(align: String, page: Int, limit: Int) {
        guard let token = keychain.get(Keys.token) else { return }
        self.spinner.startAnimating()
        Network.request(req: GetJournalRequest(token: token, align: align, page: page, limit: limit)) { result in
            switch result {
            case .success(let response):
                self.spinner.stopAnimating()
                if response.code == 1000 {
                    self.journalCount = response.journalcount
                    guard let result = response.result else { return }
                    self.journalList = result
                    self.didRetrieveData()
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
                }
                
            case .cancel(let cancel):
                print(cancel as Any)
                self.spinner.stopAnimating()
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
            case .failure(let error):
                print(error?.localizedDescription as Any)
                self.spinner.stopAnimating()
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
            }
        }
        
    }
    
    // 일지 페이징 시 reload 
    private func getMoreJournal(align: String, page: Int, limit: Int) {
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: GetJournalRequest(token: token, align: align, page: page, limit: limit)) { result in
            switch result {
            case .success(let response):
                self.spinner.stopAnimating()
                if response.code == 1000 {
                    guard let result = response.result else { return }
                    if result.count > 0 {
                        for i in 0...(result.count-1) {
                            self.journalList.append(result[i])
                        }
                        self.didRetrieveMoreData()
                    } else {
                        print("마지막 페이지입니다. ")
                        self.isEnd = true
                    }
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
                }
            case .cancel, .failure:
                self.spinner.stopAnimating()
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
            }
        }
    }
    
    // 일지 삭제
    private func deleteJournal(journalID: Int, index: Int) {
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: DeleteJournalRequest(token: token, journalID: journalID)) { result in
            switch result {
            case .success(let response):
                print(response)
                if response.code == 1000 {
                    self.didDeleteData(index: index)
                } else {
                    let message = response.message
                    DispatchQueue.main.async {
                        self.presentAlert(title: message)
                    }
                }
            case .cancel(let cancelError):
                print(cancelError as Any)
            case .failure(let error):
                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.")
                print(error as Any)
            }
        }
    }
}
