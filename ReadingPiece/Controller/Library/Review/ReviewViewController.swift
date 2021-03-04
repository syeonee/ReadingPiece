//
//  ReviewViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/04.
//

import UIKit

class ReviewViewController: UIViewController {
    
    let reviewCell = ReviewCell()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: reviewCell.cellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 263.5
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

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reviewCell.cellID) as! ReviewCell
        return cell
    }
    
    
}
