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
    
    static var dummyData = [
        //Journal(bookTitle: "보건교사 안은영", content: "인증 1일차. 보건교사다 잽싸게 도망가자 ", date: Date(timeIntervalSinceNow: 86400*5), readingPercentage: 48, time: "1시간 10분"),
        //Journal(bookTitle: "아르센 벵거 자서전 My Life in Red and White", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", date: Date(timeIntervalSinceNow: 86400*4), readingPercentage: 60, time: "30분"),
        //Journal(bookTitle: "달러구트 꿈 백화점", content: "달러구트 꿈 백화점은 우리에게 또다른 세상을 보여준다. 우리가 전혀 알지 못했던 사실을 익숙하면서도", date: Date(timeIntervalSinceNow: 86400*3), readingPercentage: 10, time: "10시간 35분"),
        Journal(bookTitle: "보건교사 안은영", content: "인증 1일차. 보건교사다 잽싸게 도망가자  인증 1일차. 보건교사다 잽싸게 도망가자", date: Calendar.current.date(byAdding: .day, value: 3, to: Date(timeIntervalSinceNow: 86400*2))!, readingPercentage: 48, time: "1시간 10분"),
        Journal(bookTitle: "아르센 벵거 자서전 My Life in Red and White", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", date: Date(timeIntervalSinceNow: 86400), readingPercentage: 60, time: "30분"),
        Journal(bookTitle: "달러구트 꿈 백화점", content: "달러구트 꿈 백화점은 우리에게 또다른 세상을 보여준다. 우리가 전혀 알지 못했던 사실을 익숙하면서도", date: Date(), readingPercentage: 10, time: "10시간 35분")
    ]
}
