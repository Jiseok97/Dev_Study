//
//  NewsListService.swift
//  JSNews
//
//  Created by 이지석 on 2022/04/28.
//

import Foundation
import RxSwift
import RxCocoa

struct NewsListService {
    
    static let shared = NewsListService()
    
    let disposeBag = DisposeBag()
    
    func fetchNewsData(completion: @escaping([Article]) -> Void) {
        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: { result in
                if let result = result {
                    completion(result.articles)
                }
            }).disposed(by: disposeBag)
    }
    
}
