//
//  UIImage.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/05/11.
//

import UIKit

extension UIImage
{
    // Given a required height, returns a (rasterised) copy
    // of the image, aspect-fitted to that height.

    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage
    {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
    
    func aspectFittedToWidth(_ newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
