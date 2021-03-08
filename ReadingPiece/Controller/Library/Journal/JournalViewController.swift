//
//  JournalViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/04.
//

import UIKit

class JournalViewController: UIViewController {
    
    let journalCell = JournalCell()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "JournalCell", bundle: nil), forCellReuseIdentifier: journalCell.cellID)
        
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 150
        tableView.rowHeight = 150
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.9646214843, green: 0.9647600055, blue: 0.9645912051, alpha: 1)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: journalCell.cellID) as! JournalCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("JournalHeaderCell", owner: self, options: nil)?.first as! JournalHeaderCell
        return headerView
    }
    
    
}
