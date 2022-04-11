//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by Mohammad Azam on 2/13/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import Photos

private let reuserIdentifier = "PhotoCollectionViewCell"

class PhotosCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var images = [PHAsset]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        populatePhotos()
    }
   
    
    // MARK: - Functions
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            
            if status == .authorized {
                // access the photos from photo library
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                
                self?.images.reverse()
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
}


// MARK: - UICollectionView DataSource

extension PhotosCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuserIdentifier, for: indexPath) as? PhotoCollectionViewCell else { fatalError("PhotoCollectionViewCell is not found")}
        
        let asset = self.images[indexPath.row]
        
        cell.configureCell(with: asset)
        
        return cell
    }
}
