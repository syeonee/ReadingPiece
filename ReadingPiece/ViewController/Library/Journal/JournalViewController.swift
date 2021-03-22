//
//  JournalViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/04.
//

import UIKit

class JournalViewController: UIViewController {
    
    let journalCell = JournalCell()
    let fullJournalCell = FullJournalCell()
    let headerView = JournalHeaderCell()
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "y.MM.dd"
        return f
    } ()
    
    // 더보기 기능을 위한 0 또는 1 값을 저장하기 위한 Array
    var more: [Int] = []
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        self.more = Array<Int>(repeating: 0, count: Journal.dummyData.count)
    }
    
}

extension JournalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = Journal.dummyData.count
        if count == 0 {
            let message = "아직 인증이 없어요. \n매일 독서 시간과 소감을 기록하고 \n챌린지를 달성해요!"
            tableView.setEmptyView(image: UIImage(named: "recordIcon")!, message: message, buttonTitle: "독서 시작하기") { [self] in
                buttonAction()
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let length = Journal.dummyData[0].content.utf8.count
        
        if Journal.dummyData[indexPath.row].content.utf8.count <= length {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullJournalCell.cellID) as! FullJournalCell
            let journal = Journal.dummyData[indexPath.row]
            cell.bookTitleLabel.text = journal.bookTitle
            cell.journalTextLabel.text = journal.content
            cell.dateLabel.text = dateFormatter.string(from: journal.date)
            cell.readingPercentageLabel.text = "\(journal.readingPercentage)% 읽음"
            cell.readingTimeLabel.text = journal.time
            
            cell.editDelegate = self
            return cell
        } else if more[indexPath.row] == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: journalCell.cellID) as! JournalCell
            let journal = Journal.dummyData[indexPath.row]
            cell.bookTitleLabel.text = journal.bookTitle
            cell.journalTextLabel.text = journal.content
            cell.dateLabel.text = dateFormatter.string(from: journal.date)
            cell.readingPercentLabel.text = "\(journal.readingPercentage)% 읽음"
            cell.readingTimeLabel.text = journal.time
            
            cell.moreDelegate = self
            cell.editDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullJournalCell.cellID) as! FullJournalCell
            let journal = Journal.dummyData[indexPath.row]
            cell.bookTitleLabel.text = journal.bookTitle
            cell.journalTextLabel.text = journal.content
            cell.dateLabel.text = dateFormatter.string(from: journal.date)
            cell.readingPercentageLabel.text = "\(journal.readingPercentage)% 읽음"
            cell.readingTimeLabel.text = journal.time
            
            cell.editDelegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if Journal.dummyData.count == 0 {
            return nil
        } else {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerView.identifier) as! JournalHeaderCell
            cell.count.text = String(Journal.dummyData.count)
            cell.recentDelegate = self
            cell.oldDelegate = self
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if Journal.dummyData.count == 0 {
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
            Journal.dummyData.remove(at: indexPath[1])
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
        Journal.dummyData.sort(by: { $0.date < $1.date })
        tableView.reloadData()
    }
    
    func sortRecentFirst() {
        Journal.dummyData.sort(by: { $0.date > $1.date })
        tableView.reloadData()
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
