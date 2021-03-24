//
//  PieceInfoViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/23.
//

import UIKit
import PanModal

class PieceInfoViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}

extension PieceInfoViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(427)
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(427)
    }
    
}
