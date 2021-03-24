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
    
    // 더보기 기능을 위한 0 또는 1 값을 저장하기 위한 Array
    var more: [Int] = []
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getJournalData()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "JournalCell", bundle: nil), forCellReuseIdentifier: journalCell.cellID)
        tableView.register(UINib(nibName: "FullJournalCell", bundle: nil), forCellReuseIdentifier: fullJournalCell.cellID)
        tableView.register(UINib(nibName: "JournalHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: headerView.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = .none
        tableView.backgroundColor = .lightgrey2
        
        // 더보기 값 배열 초기화
        self.more = Array<Int>(repeating: 0, count: journalList.count)
    }
    
    private func getJournalData() {
        self.showIndicator()
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: GetJournalRequest(token: token, align: "desc")) { result in
            switch result {
            case .success(let response):
                debugPrint(response)
                self.dismissIndicator()
                guard let result = response.result else { return }
                self.journalList = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .cancel(let cancelError):
                print(cancelError as Any)
                self.dismissIndicator()
            case .failure(let error):
                print(error?.localizedDescription as Any)
                self.dismissIndicator()
            }
        }
    }
    
}

extension JournalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = journalList.count
        if count == 0 {
            let message = "아직 인증이 없어요. \n매일 독서 시간과 소감을 기록하고 \n챌린지를 달성해요!"
            tableView.setEmptyView(image: UIImage(named: "recordIcon")!, message: message, buttonTitle: "독서 시작하기") { [self] in
                buttonAction()
            }
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
            //cell.dateLabel.text = dateFormatter.string(from: journal.date)
            cell.dateLabel.text = journal.postAt
            cell.readingPercentageLabel.text = "\(journal.percent)% 읽음"
            cell.readingTimeLabel.text = "\(journal.time)분"
            
            cell.editDelegate = self
            return cell
        } else if more[indexPath.row] == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: journalCell.cellID) as! JournalCell
            let journal = journalList[indexPath.row]
            cell.bookTitleLabel.text = journal.title
            cell.journalTextLabel.text = journal.text
            //cell.dateLabel.text = dateFormatter.string(from: journal.date)
            cell.dateLabel.text = journal.postAt
            cell.readingPercentLabel.text = "\(journal.percent)% 읽음"
            cell.readingTimeLabel.text = "\(journal.time)분"
            
            cell.moreDelegate = self
            cell.editDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullJournalCell.cellID) as! FullJournalCell
            let journal = journalList[indexPath.row]
            cell.bookTitleLabel.text = journal.title
            cell.journalTextLabel.text = journal.text
            //cell.dateLabel.text = dateFormatter.string(from: journal.date)
            cell.dateLabel.text = journal.postAt
            cell.readingPercentageLabel.text = "\(journal.percent)% 읽음"
            cell.readingTimeLabel.text = "\(journal.time)분"
            
            cell.editDelegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if journalList.count == 0 {
            return nil
        } else {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerView.identifier) as! JournalHeaderCell
            cell.count.text = String(journalList.count)
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

// 더보기 기능 관련
extension JournalViewController: JournalMoreDelegate {
    func didTapMoreButton(cell: JournalCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        print("JournalViewController - didTapMoreButton() called. indexPath: \(String(describing: indexPath))")
        self.more[indexPath![1]] = 1
        
        self.tableView.reloadRows(at: [IndexPath(row: indexPath![1], section: 0)], with: .fade)
    }
}

// 수정 기능 관련
extension JournalViewController: JournalEditDelegate, FullJournalEditDelegate {
    func didTapFullEditButton(cell: FullJournalCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        print("JournalViewController - didTapFullEditButton() called. indexPath: \(String(describing: indexPath))")
        showAlert(indexPath: indexPath!)
    }
    
    func didTapEditButton(cell: JournalCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        print("JournalViewController - didTapEditButton() called. indexPath: \(String(describing: indexPath))")
        showAlert(indexPath: indexPath!)
    }
    
    func showAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let success = UIAlertAction(title: "첨부한 사진 보기", style: .default) { (action) in
            print("첨부한 사진 보기")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            // 삭제 api 호출 (인디케이터 없이)
            self.journalList.remove(at: indexPath[1])
            self.more.remove(at: indexPath[1])
            self.tableView.deleteRows(at: [IndexPath(row: indexPath[1], section: 0)], with: .left)
            self.tableView.reloadData()  // 섹션 헤더 reload 위해 사용
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        alert.addAction(destructive)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// 정렬 기능
extension JournalViewController: JournalOldestDelegate, JournalLatestDelegate {
    func sortOldFirst() {
        
        //Journal.dummyData.sort(by: { $0.date < $1.date })
        //tableView.reloadData()
    }
    
    func sortRecentFirst() {
        //Journal.dummyData.sort(by: { $0.date > $1.date })
        //tableView.reloadData()
    }
}

// 데이터가 없을 경우 표시되는 Placeholder
extension JournalViewController {
    
    func buttonAction () {
        print("독서 시작 - 홈탭으로 이동 후 타이머 VC로 이동해야 함")
        
        //let homeNavigationVC = MyNavViewController()
        //let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "") as! MyNavViewController
        
        /*
        let timerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timerVC") as! TimerViewController
        //self.navigationController?.pushViewController(TimerVC, animated: true)
        
        let viewControllers = self.navigationController!.viewControllers
        let newViewControllers = NSMutableArray()
        
        // preserve the root view controller
        newViewControllers.add(viewControllers[0])
        // add the new view controller
        newViewControllers.add(timerVC)
        self.navigationController?.setViewControllers(newViewControllers as! [UIViewController], animated: true)
        */
    }
    
    
}
