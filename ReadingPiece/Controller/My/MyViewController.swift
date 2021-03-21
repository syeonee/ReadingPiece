//
//  MyViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/24.
//

import UIKit
import PagingKit

class MyViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resolutionLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    static var contentView: (String) -> UIViewController = { (menu) in
        let sb = UIStoryboard(name: "My", bundle: nil)
        var vc = UIViewController()
        if menu == "통계" {
            vc = sb.instantiateViewController(identifier: "StatisticsController") as! StatisticsViewController
        } else {
            vc = sb.instantiateViewController(identifier: "MyPieceController") as! MyPieceViewController
        }
        return vc
    }
    
    var dataSource = [(menuTitle: "통계", vc: contentView("통계")), (menuTitle: "나의 피스", vc: contentView("나의 피스"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        menuViewController.register(nib: UINib(nibName: "MyMenuCell", bundle: nil), forCellWithReuseIdentifier: "MyMenuCell")
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self
            menuViewController.delegate = self
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
        }
    }
    
}

extension MyViewController: PagingMenuViewControllerDataSource, PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
    
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MyMenuCell", for: index) as! MyMenuCell
            cell.menuLabel.text = dataSource[index].menuTitle
            return cell
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 74
    }
}

extension MyViewController: PagingContentViewControllerDataSource, PagingContentViewControllerDelegate {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].vc
    }
    
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
            menuViewController.scroll(index: index, percent: percent, animated: false)
        }
}
