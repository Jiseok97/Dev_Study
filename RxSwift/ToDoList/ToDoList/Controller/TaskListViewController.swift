//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by 이지석 on 2022/04/16.
//

import Foundation
import UIKit

class TaskListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    // MARK: - Functions
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
}



// MARK: - UITableView Delegate/DataSource

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
