//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by 이지석 on 2022/04/16.
//

import UIKit

class AddTaskViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
    }
    
    
    // MARK: - Selectors
    
    @objc func saveButtonTapped() {
        
        guard let priority = Priority(rawValue: self.prioritySegmentControl.selectedSegmentIndex),
              let title = self.taskTitleTextField.text else { return }
        
        let task = Task(title: title, priority: priority)
        
        
    }
    
    
    // MARK: - Functions

    private func configureNavigation() {
        self.navigationItem.title = "Add Task"
        self.navigationItem.largeTitleDisplayMode = .never

        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = save
    }
}
