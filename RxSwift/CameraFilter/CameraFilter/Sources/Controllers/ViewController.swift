//
//  ViewController.swift
//  CameraFilter
//
//  Created by Mohammad Azam on 2/13/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? UINavigationController,
              let photosController = controller.viewControllers.first as? PhotosCollectionViewController
        else { fatalError("Segue destination is not found") }
        
        photosController.seletedPhoto.subscribe(onNext: { [weak self] photo in
            self?.photoImageView.image = photo
        }).disposed(by: disposeBag)
        
    }

}

