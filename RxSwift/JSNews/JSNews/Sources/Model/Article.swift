//
//  Article.swift
//  JSNews
//
//  Created by 이지석 on 2022/04/23.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let descrtiption: String
}
