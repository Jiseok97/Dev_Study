//
//  ViewModel.swift
//  UTCTime
//
//  Created by 이지석 on 2022/02/02.
//

/// 뷰를 위한 Model
/// Service를 사용하고, 그를 통한 값을 내부에서 화면에 보여줄 수 있는 형태로 변형하는 역할

import Foundation

class ViewModel {
    var onUpdated: () -> Void = {}
    
    var dateTimeString: String = "로딩중.."    // 화면에 보여져야할 값(String)
    {
        didSet {
            onUpdated()
        }
    }
    
    let service = Service()
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
    
    func reload() {
        // Service를 이용해 model의 currentDateTime을 불러옴
        //
        service.fetchNow { [weak self] model in
            guard let self = self else { return }
            let dateString = self.dateToString(date: model.currentDateTime)
            self.dateTimeString = dateString
        }
    }
    
    func moveDay(day: Int) {
        service.moveDay(day: day)
        dateTimeString = dateToString(date: service.currentModel.currentDateTime)
    }
}
