//
//  UITableView.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/20.
//

import UIKit

extension UITableView {
    
    func setEmptyView(image: UIImage, message: String, buttonType: String, actionButtonClosure: @escaping () -> Void) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let imageView = UIImageView()
        let messageLabel = UILabel()
        let button: UIButton = {
            let button = UIButton()
            if buttonType == "review" {
                button.setImage(UIImage(named: "createReviewButton"), for: .normal)
            } else {
                button.setImage(UIImage(named: "startReadingButton"), for: .normal)
            }
            return button
        } ()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.font = .NotoSans(.medium, size: 15)
        messageLabel.textColor = .charcoal
        
        emptyView.addSubview(imageView)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(button)
        emptyView.backgroundColor = #colorLiteral(red: 0.9646214843, green: 0.9647600055, blue: 0.9645912051, alpha: 1)
        
        imageView.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 42).isActive = true
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 57).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 63).isActive = true
        messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 60).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -60).isActive = true
        //button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 65).isActive = true
        button.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: 314).isActive = true
        button.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 40).isActive = true
        button.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        button.addAction {
            actionButtonClosure()
        }
        
        
        imageView.image = image
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restoreWithLine() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func restoreWithoutLine() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
    
}
