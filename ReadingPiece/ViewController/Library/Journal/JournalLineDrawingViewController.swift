//
//  JournalLineDrawingViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/05/11.
//

import UIKit

class JournalLineDrawingViewController: UIViewController {
    
    var image: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        if let img = self.image {
            imageView.image = img
        }
        
        self.navigationItem.title = "밑줄 긋기"
        //self.navigationController?.navigationBar.topItem?.title = ""
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(drawLine))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .main
        self.navigationController?.navigationBar.tintColor = .darkgrey
    }
    
    @objc private func drawLine() {
        
    }

}
