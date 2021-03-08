//
//  Review.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/06.
//

import UIKit

class Review {
    var thumbnailImage: UIImage
    var bookTitle: String
    var author: String
    var rating: String
    var reviewText: String
    var date: Date
    
    
    init(thumbnailImage: UIImage, bookTitle: String, author: String, rating: String, reviewText: String, date: Date) {
        self.thumbnailImage = thumbnailImage
        self.bookTitle = bookTitle
        self.author = author
        self.rating = rating
        self.reviewText = reviewText
        self.date = date
    }
    
}
