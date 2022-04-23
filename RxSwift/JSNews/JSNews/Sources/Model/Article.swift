//
//  Article.swift
//  JSNews
//
//  Created by 이지석 on 2022/04/23.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

extension ArticlesList {
    
    static var all: Resource<ArticlesList> = {
        let url = URL(string: API_URL)!
        return Resource(url: url)
    }()
    
}

struct Article: Decodable {
    let title: String
    let description: String?
}
