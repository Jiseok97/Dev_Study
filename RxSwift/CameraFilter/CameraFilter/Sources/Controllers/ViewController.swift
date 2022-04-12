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
    @IBOutlet weak var applyFilterButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.prefersLargeTitles = true
        configureUI()
    }

    
    
    // MARK: - Functions
    
    private func configureUI() {
        applyFilterButton.layer.cornerRadius = applyFilterButton.frame.height / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? UINavigationController,
              let photosController = controller.viewControllers.first as? PhotosCollectionViewController
        else { fatalError("Segue destination is not found") }
        
        photosController.seletedPhoto.subscribe(onNext: { [weak self] photo in
            
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            
        }).disposed(by: disposeBag)
        
    }
    
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }
    
    
    @IBAction func applyFilterButtonTapped() {
        
        guard let sourceImage = self.photoImageView.image else { return }
        
        FilterService().applyeFilter(to: sourceImage) { filteredImage in
            
            DispatchQueue.main.async {
                self.photoImageView.image = filteredImage
            }
            
        }
        
    }
    
}
