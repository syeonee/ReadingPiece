//
//  DaillyDiaryWrittenCompletionViewController.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/08.
//

import UIKit

class DaillyDiaryWrittenCompletionViewController: UIViewController {

    @IBOutlet weak var daillyDiaryWrittenTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setNavBar()
        setupTableView()
    }
    
    private func setNavBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .darkgrey
        let rightButton = UIBarButtonItem(image: UIImage(named: "shareIconLine"), style: .plain, target: self, action: #selector(shareDaillyReadingResult(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .darkgrey
    }

    private func setupTableView() {
//        daillyDiaryWrittenTableView.backgroundColor = .tableViewBackroundGray
        daillyDiaryWrittenTableView.delegate = self
        daillyDiaryWrittenTableView.dataSource = self
        daillyDiaryWrittenTableView.register(UINib(nibName: ChallengeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ChallengeTableViewCell.identifier)
        daillyDiaryWrittenTableView.register(UINib(nibName: DaillyReadingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DaillyReadingTableViewCell.identifier)
    }
    
    @objc func shareDaillyReadingResult(sender: UIBarButtonItem){
        
    }
}

extension DaillyDiaryWrittenCompletionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let challengeCell = tableView.dequeueReusableCell(withIdentifier: ChallengeTableViewCell.identifier, for: indexPath) as? ChallengeTableViewCell
                else { return UITableViewCell() }
            return challengeCell
        default:
            guard let daillyReadingCell = tableView.dequeueReusableCell(withIdentifier: DaillyReadingTableViewCell.identifier, for: indexPath) as? DaillyReadingTableViewCell
                else { return UITableViewCell() }
            return daillyReadingCell
        }
    }
}

extension DaillyDiaryWrittenCompletionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.backgroundColor = .systemGray6
    }
}
