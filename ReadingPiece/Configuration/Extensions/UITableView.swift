//
//  UITableView.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/20.
//

import UIKit

extension UITableView {
    
    // 테이블 뷰 placeholder 뷰 생성
    // 이미지, 텍스트, 버튼 액션 커스텀 가능
    func setEmptyView(image: UIImage, message: String, buttonType: String, actionButtonClosure: @escaping () -> Void) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let imageView = UIImageView()
        let messageLabel = UILabel()
        let button: UIButton = {
            let button = UIButton()
            if buttonType == "review" {
                button.setImage(UIImage(named: "createReviewButton"), for: .normal)
            } else if buttonType == "journal" {
                button.setImage(UIImage(named: "startReadingButton"), for: .normal)
            } else {
                button.makeRoundedButtnon(buttonType, titleColor: .white, borderColor: UIColor.melon.cgColor, backgroundColor: .melon)
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
        
        if buttonType == "review" {
            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 65).isActive = true
        } else {
            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 40).isActive = true
        }
        
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
    
    // MARK: 흰배경 인디케이터 표시
    func showWhiteIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showWhiteIndicator()
    }
    // MARK: 인디케이터 숨김
    func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
    
    // 테이블뷰 리로드 후 completion handler 필요할 때
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
    
    // 테이블 뷰 리로드 후 스크롤 위치 변경할 때
    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.async() {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                     let indexPath = IndexPath(row: 0, section: 0)
                     self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }
    enum scrollsTo {
        case top,bottom
    }

    
}
