//
//  Service.swift
//  UTCTime
//
//  Created by 이지석 on 2022/02/02.
//

/// Repository를 이용해서 Entity를 Logic에서 사용하는 Model로 바꿔주는 역할

import Foundation

class Service {
    let repository = Repository()
    
    var currentModel = Model(currentDateTime: Date())
    
    func fetchNow(onCompleted: @escaping (Model) -> Void) {
        
        /// Entity를 Model로 변형
        repository.fetchNow { [weak self] entity in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T' HH:mm'Z'"
            
            guard let now = formatter.date(from: entity.currentDateTime) else { return }
            
            let model = Model(currentDateTime: now)
            self?.currentModel = model
            
            onCompleted(model)
        }
    }
    
    func moveDay(day: Int) {
        guard let movedDay = Calendar.current.date(byAdding: .day,
                                                   value: day,
                                                   to: currentModel.currentDateTime) else {
            return
        }
        currentModel.currentDateTime = movedDay
    }
}
