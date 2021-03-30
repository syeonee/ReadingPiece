//
//  JournalImageViewController.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/28.
//

import UIKit

class JournalImageViewController: UIViewController {
    
    var imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        getImage(url: imageURL)
        
    }
    
    private func getImage(url: String) {
        if let url = URL(string: url) {
            self.imageView.kf.setImage(with: url)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
