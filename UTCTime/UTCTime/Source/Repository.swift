//
//  Repository.swift
//  UTCTime
//
//  Created by 이지석 on 2022/02/02.
//

/// Server Model(Entity)를 전달해주는 역할

import Foundation

class Repository {
    func fetchNow(onCompletion: @escaping (UtcTimeModel) -> Void) {
        let url = "http://worldclockapi.com/api/json/utc/now"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
            onCompletion(model)
        }.resume()
    }
}
