//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by 이지석 on 2022/04/16.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    // MARK: - Functions
    
    private func configureUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    private func filterTasks(by priority: Priority?) {
        
        if priority == nil {
            self.filteredTasks = self.tasks.value
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority! }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                print("DEBUG: tasks is \(tasks)")
            }).disposed(by: disposeBag)
        }
    }
    
    @IBAction func priorityValueChanded(segmentedControl: UISegmentedControl) {
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
}



// MARK: - UITableView Delegate/DataSource

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController,
              let addController = navController.viewControllers.first as? AddTaskViewController else {
                  fatalError("Controller not found..")
              }
        
        addController.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
                
                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                
                var taskValue = self.tasks.value
                taskValue.append(task)
    
                self.tasks.accept(taskValue)
                self.filterTasks(by: priority)

            }).disposed(by: disposeBag)
        
    }
    
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
