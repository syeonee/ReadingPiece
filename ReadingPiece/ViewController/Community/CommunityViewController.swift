//
//  CommunityViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/24.
//

import UIKit

class CommunityViewController: UIViewController {

    let journalCell = JournalCell()
    let fullJournalCell = FullJournalCell()
    let headerView = JournalHeaderCell()
    // 더보기 기능을 위한 0 또는 1 값을 저장하기 위한 Array
    var more: [Int] = []

    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "y.MM.dd"
        return f
    } ()
    
    @IBOutlet weak var journalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 더보기 값 배열 초기화
        self.more = Array<Int>(repeating: 0, count: Journal.dummyData.count)
        setupUI()
    }
    
    private func setupUI() {
        setTableView()
    }
    
    private func setTableView() {
        journalTableView.dataSource = self
        journalTableView.delegate = self
        journalTableView.register(UINib(nibName: "JournalCell", bundle: nil), forCellReuseIdentifier: journalCell.cellID)
        journalTableView.register(UINib(nibName: "FullJournalCell", bundle: nil), forCellReuseIdentifier: fullJournalCell.cellID)
        journalTableView.register(UINib(nibName: "JournalHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: headerView.identifier)
        
        journalTableView.rowHeight = UITableView.automaticDimension
        journalTableView.estimatedRowHeight = 150
        journalTableView.separatorStyle = .none
        journalTableView.backgroundColor = .lightgrey2
    }

}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = Journal.dummyData.count
        if count == 0 {
            let message = "아직 인증이 없어요. \n매일 독서 시간과 소감을 기록하고 \n챌린지를 달성해요!"
            self.setEmptyView(image: UIImage(named: "recordIcon")!, message: message)
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
            cell.index = indexPath.row
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
            cell.index = indexPath.row
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
            cell.index = indexPath.row
            cell.editDelegate = self
            return cell
        }
    }

}

extension CommunityViewController: JournalMoreDelegate {
    func didTapMoreButton(index: Int) {
        self.more[index] = 1
        self.journalTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

// 수정 기능 관련
extension CommunityViewController: JournalEditDelegate, FullJournalEditDelegate {
    func didTapEditButton(index: Int) {
        showAlert(index: index)
    }
    
    func didTapFullEditButton(index: Int) {
        showAlert(index: index)
    }
    
    func showAlert(index: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let success = UIAlertAction(title: "수정", style: .default) { (action) in
            print("게시글 작성자만 게시글 수정")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            Journal.dummyData.remove(at: index)
            self.more.remove(at: index)
            self.journalTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            self.journalTableView.reloadData()  // 섹션 헤더 reload 위해 사용
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        alert.addAction(destructive)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// 정렬 기능
extension CommunityViewController: JournalOldestDelegate, JournalLatestDelegate {
    func sortOldFirst() {
        Journal.dummyData.sort(by: { $0.date < $1.date })
        journalTableView.reloadData()
    }
    
    func sortRecentFirst() {
        Journal.dummyData.sort(by: { $0.date > $1.date })
        journalTableView.reloadData()
    }
}

extension CommunityViewController {
    // 테이블 뷰에 데이터가 없을 경우 표시되는 placeholder
    func setEmptyView(image: UIImage, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let imageView = UIImageView()
        let messageLabel = UILabel()
        let button = UIButton()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.font = .NotoSans(.medium, size: 15)
        messageLabel.textColor = .charcoal
        button.titleLabel?.font = .NotoSans(.medium, size: 15)
        button.makeRoundedButtnon("독서 시작하기", titleColor: .white, borderColor: UIColor.melon.cgColor, backgroundColor: .melon)
        
        emptyView.addSubview(imageView)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(button)
        emptyView.backgroundColor = #colorLiteral(red: 0.9646214843, green: 0.9647600055, blue: 0.9645912051, alpha: 1)
        
        //imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 42).isActive = true
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 57).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 63).isActive = true
        messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 80).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -80).isActive = true
        button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 40).isActive = true
        button.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 40).isActive = true
        button.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        
        imageView.image = image
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.journalTableView.backgroundView = emptyView
        self.journalTableView.separatorStyle = .none
    }
    
    @objc func buttonAction (_ sender: UIButton!) {
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
