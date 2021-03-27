//
//  JournalImageViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/28.
//

import UIKit

class JournalImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
