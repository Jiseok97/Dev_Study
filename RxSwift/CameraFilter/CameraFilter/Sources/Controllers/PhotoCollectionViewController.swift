//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by 이지석 on 2022/04/08.
//

import Foundation
import UIKit
import Photos

class PhotoCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    
    // MARK: - Funcitons
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { status in
            
            if status == .authorized {
                // 승인
                
                
                
            }
            
        }
    }
    
}
