//
//  WeatherRepository.swift
//  weatherApp
//
//  Created by 이지석 on 2022/01/07.
//

import Alamofire

class WeahterRepository  {
    func showWeather(completion: @escaping (WeatherEntity) -> ()) {
        AF.request(Constant.BASE_URL + "?q=Osan&appid=\(Constant.APP_KEY)&units=metric", method: .get)
            .validate()
            .responseDecodable(of: WeatherEntity.self) { response in
                guard let data = response.value else { return }
                completion(data)
            }
    }
}
