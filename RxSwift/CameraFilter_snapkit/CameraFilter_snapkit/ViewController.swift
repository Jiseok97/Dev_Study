//
//  ViewController.swift
//  CameraFilter_snapkit
//
//  Created by 이지석 on 2022/05/14.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        configureNavigationBar()
    }
    
    // MARK: - Selector
    
    @objc func handleAdd() {
        print("Tapped nav")
    }

    
    // MARK: - Functions
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .black
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.link]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .link
        
//        navigationItem.title = "Edit Profile"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }

}

