//
//  NewsTableViewController.swift
//  JSNews
//
//  Created by 이지석 on 2022/04/21.
//

import Foundation
import UIKit

class NewsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifycycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Functions
    
    private func configureUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
