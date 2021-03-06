//
//  ReviewViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/04.
//

import UIKit

class ReviewViewController: UIViewController {
    
    let reviewCell = ReviewCell()
    let fullReviewCell = FullReviewCell()
    
    let textSample = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: reviewCell.cellID)
        tableView.register(UINib(nibName: "FullReviewCell", bundle: nil), forCellReuseIdentifier: fullReviewCell.cellID)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 263.5
        
        //let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        //header.backgroundColor = .systemOrange
        //tableView.tableHeaderView = header
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row <= 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCell.cellID) as! ReviewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: fullReviewCell.cellID) as! FullReviewCell
            cell.reviewTextLabel.text = textSample
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("ReviewHeaderCell", owner: self, options: nil)?.first as! ReviewHeaderCell
        return headerView
    }
    
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        guard let tableViewLayoutMargin = tableViewLayoutMargin else { return }
        
        tableView.layoutMargins = tableViewLayoutMargin
    }

    /// To support safe area, all tableViews aligned on scrollView needs to be set margin for the cell's contentView and separator.
    
    @available(iOS 11.0, *)
    private var tableViewLayoutMargin: UIEdgeInsets? {
        guard let superview = parent?.view else {
            return nil
        }
        
        let defaultTableContentInsetLeft: CGFloat = 16
        return UIEdgeInsets(
            top: 0,
            left: superview.safeAreaInsets.left + defaultTableContentInsetLeft,
            bottom: 0,
            right: 0
        )
    }
    
}
