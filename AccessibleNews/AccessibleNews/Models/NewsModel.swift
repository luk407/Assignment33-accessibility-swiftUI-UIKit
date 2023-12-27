//
//  NewsModel.swift
//  AccessibleNews
//
//  Created by Luka Gazdeliani on 27.12.23.
//

import Foundation

struct NewsData: Decodable {
    let news: [News]
}

struct News: Decodable, Identifiable {
    let id: Int
    let title: String
    let text: String
    let image: String
    let publishDate : String

    enum CodingKeys: String, CodingKey {
        case id, title, text, image
        case publishDate = "publish_date"
    }
}
