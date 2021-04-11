//
//  Feed.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/29.
//
import Foundation

public struct Feed: Codable {
    public let title: String
    public let imageURL: String?
    public let writer: String
    public let bookId: Int
    public let publishNumber: String
    public let percent: Int
    public let page: Int
    public let time: Int
    public let status: String
    public let postAt: String
    public let text: String
    public let journalId: Int
    public let userId: Int
    public let profilePic: String?
    public let name: String?
}
