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
    
    // 기본 데이터 리스트는 최신순으로 자동으로 추가되어 있어야 함
    var journals = [
        Journal(bookTitle: "보건교사 안은영", content: "인증 1일차. 보건교사다 잽싸게 도망가자 ", date: Date(timeIntervalSinceNow: 86400*5), readingPercentage: 48, time: "1시간 10분"),
        Journal(bookTitle: "아르센 벵거 자서전 My Life in Red and White", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", date: Date(timeIntervalSinceNow: 86400*4), readingPercentage: 60, time: "30분"),
        Journal(bookTitle: "달러구트 꿈 백화점", content: "달러구트 꿈 백화점은 우리에게 또다른 세상을 보여준다. 우리가 전혀 알지 못했던 사실을 익숙하면서도", date: Date(timeIntervalSinceNow: 86400*3), readingPercentage: 10, time: "10시간 35분"),
        Journal(bookTitle: "보건교사 안은영", content: "인증 1일차. 보건교사다 잽싸게 도망가자  인증 1일차. 보건교사다 잽싸게 도망가자", date: Calendar.current.date(byAdding: .day, value: 3, to: Date(timeIntervalSinceNow: 86400*2))!, readingPercentage: 48, time: "1시간 10분"),
        Journal(bookTitle: "아르센 벵거 자서전 My Life in Red and White", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", date: Date(timeIntervalSinceNow: 86400), readingPercentage: 60, time: "30분"),
        Journal(bookTitle: "달러구트 꿈 백화점", content: "달러구트 꿈 백화점은 우리에게 또다른 세상을 보여준다. 우리가 전혀 알지 못했던 사실을 익숙하면서도", date: Date(), readingPercentage: 10, time: "10시간 35분")
    ]

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
        self.more = Array<Int>(repeating: 0, count: journals.count)
            }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension JournalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let length = self.journals[0].content.utf8.count
        
        if self.journals[indexPath.row].content.utf8.count <= length {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullJournalCell.cellID) as! FullJournalCell
            let journal = self.journals[indexPath.row]
            cell.bookTitleLabel.text = journal.bookTitle
            cell.journalTextLabel.text = journal.content
            cell.dateLabel.text = dateFormatter.string(from: journal.date)
            cell.readingPercentageLabel.text = "\(journal.readingPercentage)% 읽음"
            cell.readingTimeLabel.text = journal.time
            
            cell.editDelegate = self
            return cell
        } else if more[indexPath.row] == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: journalCell.cellID) as! JournalCell
            let journal = self.journals[indexPath.row]
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
            let journal = self.journals[indexPath.row]
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
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerView.identifier) as! JournalHeaderCell
        cell.count.text = String(journals.count)
        cell.recentDelegate = self
        cell.oldDelegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
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
            self.journals.remove(at: indexPath[1])
            self.tableView.deleteRows(at: [IndexPath(row: indexPath[1], section: 0)], with: .left)
            //self.tableView.reloadData()  // 섹션 헤더 reload 위해 사용
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
        journals.sort(by: { $0.date < $1.date })
        tableView.reloadData()
    }
    
    func sortRecentFirst() {
        journals.sort(by: { $0.date > $1.date })
        tableView.reloadData()
    }
}
