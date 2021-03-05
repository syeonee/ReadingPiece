//
//  TermViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/02.
//

import UIKit

class TermViewController: UIViewController {

    @IBOutlet weak var bookQuantityTextField: UITextField!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBackground(_ sender: Any) {
        bookQuantityTextField.resignFirstResponder()
    }
    
    @IBAction func termButtonTapped(_ sender: UIButton) {
        let buttons = [weekButton,monthButton,yearButton]

        buttons.forEach{ (button) in
            if button == sender {
                button?.isSelected = true
            }else {
                button?.isSelected = false
            }
        }
        
    }
}
