//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by 이지석 on 2022/04/16.
//

import Foundation
import UIKit
import RxSwift

class TaskListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let controller = AddTaskViewController()
        
        controller.taskSubjectObservable
            .subscribe(onNext: { task in
                
                print("DEBUG: task is \(task)")
                
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Functions
    
    private func configureUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
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
            .subscribe(onNext: { task in

                print("DEBUG: task is \(task)")

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
