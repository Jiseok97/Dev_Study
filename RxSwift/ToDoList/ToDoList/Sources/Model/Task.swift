//
//  TaskModel.swift
//  ToDoList
//
//  Created by 이지석 on 2022/04/19.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
