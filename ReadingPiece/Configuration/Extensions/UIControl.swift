//
//  UIControl.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/20.
//

import UIKit
extension UIControl {
    
    // UIButton 등의 competion handler 작성
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
            @objc class ClosureSleeve: NSObject {
                let closure:()->()
                init(_ closure: @escaping()->()) { self.closure = closure }
                @objc func invoke() { closure() }
            }
            let sleeve = ClosureSleeve(closure)
            addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
            objc_setAssociatedObject(self, "[\(UUID())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
}
