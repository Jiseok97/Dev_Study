//
//  ViewController.swift
//  CameraFilter
//
//  Created by 이지석 on 2022/04/07.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    // MARK: - Functions
    
    private func configureUI() {
        // for navigation bar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // for UI components
        applyFilterButton.isHidden = true
        applyFilterButton.layer.cornerRadius = applyFilterButton.frame.height / 2
    }

}

