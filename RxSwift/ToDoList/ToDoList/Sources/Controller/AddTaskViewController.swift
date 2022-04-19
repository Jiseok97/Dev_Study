//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by 이지석 on 2022/04/16.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {

    // MARK: - Properties
    
    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }

    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Functions

    @IBAction func saveButtonTapped() {
        guard let priority = Priority(rawValue: self.prioritySegmentControl.selectedSegmentIndex),
              let title = self.taskTitleTextField.text else { return }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
