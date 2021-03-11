//
//  CreateReviewViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/10.
//

import UIKit

class CreateReviewViewController: UIViewController {
    
    let bookInfoCell = ReviewBookInfoCell()
    let ratingCell = ReviewRatingCell()
    let writingCell = ReviewWritingCell()
    
    var book : Book?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ReviewBookInfoCell", bundle: nil), forCellReuseIdentifier: bookInfoCell.cellID)
        tableView.register(UINib(nibName: "ReviewRatingCell", bundle: nil), forCellReuseIdentifier: ratingCell.cellID)
        tableView.register(UINib(nibName: "ReviewWritingCell", bundle: nil), forCellReuseIdentifier: writingCell.cellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
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

extension CreateReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: bookInfoCell.cellID) as! ReviewBookInfoCell
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ratingCell.cellID) as! ReviewRatingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: writingCell.cellID) as! ReviewWritingCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else if indexPath.row == 1{
            return 120
        } else {
            return 280
        }
    }
}
