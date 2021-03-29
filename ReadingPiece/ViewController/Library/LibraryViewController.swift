//
//  LibraryViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/02/24.
//

import UIKit
import PagingKit

class LibraryViewController: UIViewController {
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    var currentVC: Int = 0
    
    var dataSource = [(menu: String, content: UIViewController)]() {
        didSet {
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    lazy var firstLoad: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData()
        self?.firstLoad = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        menuViewController.cellAlignment = .center
        
        dataSource = makeDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = "내서재"
    }
    
    private func setNav() {
        // 네비게이션 바 border line 없애기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
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
    
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)] {
        let myMenuArray = ["평가/리뷰", "일지"]
        return myMenuArray.map {
            let title = $0
            switch title {
            case "평가/리뷰":
                let vc = UIStoryboard(name: "Library", bundle: nil).instantiateViewController(identifier: "ReviewVC") as! ReviewViewController
                return (menu: title, content: vc)
            case "일지":
                let vc = UIStoryboard(name: "Library", bundle: nil).instantiateViewController(identifier: "JournalVC") as! JournalViewController
                return (menu: title, content: vc)
            default:
                let vc = UIStoryboard(name: "Library", bundle: nil).instantiateViewController(identifier: "ReviewVC") as! ReviewViewController
                return (menu: title, content: vc)
            }
        }
    }
    
    
    @IBAction func createReview(_ sender: Any) {
        let vc = UIStoryboard(name: "Goal", bundle: nil).instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.initializer = 1
        self.navigationController?.pushViewController(vc, animated: true)
        
        //let reviewVC = CreateReviewViewController()
        //self.navigationController?.pushViewController(reviewVC, animated: true)
    }
}

// 메뉴 데이터소스
extension LibraryViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
        
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return (view.frame.width/2)
    }
        
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        cell.titleLabel.text = dataSource[index].menu
        return cell
    }
}

// 메뉴 컨트롤하는 델리게이트
extension LibraryViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
        self.currentVC = page
        //print("현재 페이지: ", currentVC)
    }
}

// 컨텐츠 데이터소스 - 내용
extension LibraryViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
        
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}
// 컨텐츠 컨트롤 델리게이트
extension LibraryViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        // 내용이 스크롤되면 메뉴를 스크롤한다
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
