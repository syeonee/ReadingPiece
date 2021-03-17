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
    var liked: Int // 좋아요 수
    var like: Bool // 좋아요 클릭 여부
    var comments: Int
    
    
    init(thumbnailImage: UIImage, bookTitle: String, author: String, rating: String, reviewText: String, date: Date, liked: Int, like: Bool, comments: Int) {
        self.thumbnailImage = thumbnailImage
        self.bookTitle = bookTitle
        self.author = author
        self.rating = rating
        self.reviewText = reviewText
        self.date = date
        self.liked = liked
        self.like = like
        self.comments = comments
    }
    
    static var dummyData = [
        Review(thumbnailImage: UIImage(named: "bookCoverImage1")!, bookTitle: "달러구트 꿈 백화점", author: "이미예", rating: "4.0", reviewText: "달러구트 꿈 백화점은 우리에게 또다른 세상을 보여준다. 우리가 전혀 알지 못했던 사실을 익숙하면서도", date: Date(), liked: 102, like: false, comments: 0),
        Review(thumbnailImage: UIImage(named: "bookCoverImage2")!, bookTitle: "나의 첫 투자수업", author: "김정환", rating: "3.0", reviewText: "최근 주식 투자에 대한 열풍이 불면서 시중에 엄청나게 많은 정보가 쏟아지고 있습니다. 그중에는 잘못된 정보도 많고 개인들이 이해하기 쉽지 않은 내용도 많습니다. 이 책은 개인 투자자가 어떻게 산업과 기업을 분석하고 공부해야하는지 그리고 실전에서의 투자는 어떻게 진행되어야 하는지 구체적이고 자세한 설명이 적혀있습니다. 투자에 관심이 있다면 꼭! 읽어보기를 권하는 책입니다.", date: Date(timeIntervalSinceNow: 10), liked: 0, like: false, comments: 100),
        Review(thumbnailImage: UIImage(named: "bookCoverImage3")!, bookTitle: "보건교사 안은영", author: "정세랑", rating: "2.0", reviewText: "예측할 수 없는 존재들과 사건들의 등장으로 나의 상상력을 극대화 시켜주는 책이다. 젤리괴물들의 모습과 안은영이 젤리괴물들을 무기들 등 이미지를 상상하며 즐거웠다. 등장인물들 각각의 캐릭터 또한 두드러져 한 명 한 명의 실제 모습을 상상해보는 것도 재미있었다.", date: Date(timeIntervalSinceNow: 20), liked: 34, like: false, comments: 1),
        Review(thumbnailImage: UIImage(named: "bookCoverImage4")!, bookTitle: "팀 개발을 위한 Git, GitHub 시작하기", author: "깃허브", rating: "4.0", reviewText: "이 책은 시나리오를 곁들인 실습으로 시작해서 깃과 깃허브를 처음 접하는 사람 또는 좀 더 깊은 난이도에서 깃과 깃허브를 다루고 싶은 개발자, 디자이너, 기획자 모두에게 유용하다. 챕터 0장에서 1시간이면 깃·깃허브의 기본 사용법을 따라할 수 있도록 구성했다. 파트1에서 손쉬운 그래픽 툴 소스트리를 통해 깃과 깃허브의 전 과정을 따라하고, 여기에 익숙하고 좀 더 중급 과정을 원하는 독자라면 파트2에서 실습을 CLI 환경에서 진행하도록 구성했다. 이 책은 시나리오를 곁들인 실습으로 시작해서 깃과 깃허브를 처음 접하는 사람 또는 좀 더 깊은 난이도에서 깃과 깃허브를 다루고 싶은 개발자, 디자이너, 기획자 모두에게 유용하다. 챕터 0장에서 1시간이면 깃·깃허브의 기본 사용법을 따라할 수 있도록 구성했다. 파트1에서 손쉬운 그래픽 툴 소스트리를 통해 깃과 깃허브의 전 과정을 따라하고, 여기에 익숙하고 좀 더 중급 과정을 원하는 독자라면 파트2에서 실습을 CLI 환경에서 진행하도록 구성했다. ", date: Date(timeIntervalSinceNow: 30), liked: 1212, like: false, comments: 68),
        Review(thumbnailImage: UIImage(named: "bookCoverImage5")!, bookTitle: "빌 게이츠, 기후 재앙을 피하는 법", author: "빌 게이츠", rating: "5.0", reviewText: "탄소 배출을 제로로 갈 수 있는 다양한 길과 여정을 살펴보고 우리가 어떻게 할 수 있는지를 밝히는 책", date: Date(timeIntervalSinceNow: 40), liked: 7, like: false, comments: 2121),
        Review(thumbnailImage: UIImage(named: "bookCoverImage5")!, bookTitle: "가나다라테스트", author: "띄어쓰기금지", rating: "5.0", reviewText: "가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하", date: Date(timeIntervalSinceNow: 40), liked: 7, like: false, comments: 2121)
    ]
    
}
