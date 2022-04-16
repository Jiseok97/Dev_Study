//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by 이지석 on 2022/04/16.
//

import UIKit

class AddTaskViewController: UIViewController {

    // MARK: - Properties

    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
    }
    
    
    // MARK: - Selectors
    
    @objc func saveButtonTapped() {
        print("DEBUG: Save button tapped!")
    }
    
    
    // MARK: - Functions

    private func configureNavigation() {
        self.navigationItem.title = "Add Task"

        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = save
    }
}
