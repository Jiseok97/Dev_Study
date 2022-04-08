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
    
    private var images = [PHAsset]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    
    // MARK: - Funcitons
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            
            if status == .authorized {
                // 승인
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { object, count, stop in
                    self?.images.append(object)
                }
                
                self?.images.reverse()
                
                
            }
        }
        
    }
    
}
