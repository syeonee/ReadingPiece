//
//  PasswordChangeViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    
    @IBOutlet weak var editCancelButton: UIBarButtonItem!
    @IBOutlet weak var editCompleteButton: UIBarButtonItem!
    
    @IBOutlet weak var originPasswordTextField: UITextField!
    @IBOutlet weak var originPasswordRemoveButton: UIButton!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordRemoveButton: UIButton!
    
    @IBOutlet weak var checkNewPasswordTextField: UITextField!
    @IBOutlet weak var checkNewPasswordRemoveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func editCancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editCompleteButtonTapped(_ sender: Any) {
        
    }
    

}
