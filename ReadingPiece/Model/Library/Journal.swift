//
//  Journal.swift
//  ReadingPiece
//
//  Created by 정지현 on 2021/03/09.
//

import Foundation

class Journal {
    var bookTitle: String
    var content: String
    var date: Date
    var readingPercentage: Int
    var time: String
    
    init(bookTitle: String, content: String, date: Date, readingPercentage: Int, time: String) {
        self.bookTitle = bookTitle
        self.content = content
        self.date = date
        self.readingPercentage = readingPercentage
        self.time = time
    }
}
