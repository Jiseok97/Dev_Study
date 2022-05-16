//
//  PhotoCollectionViewController.swift
//  CameraFilter_snapkit
//
//  Created by 이지석 on 2022/05/14.
//

import Foundation
import UIKit
import SnapKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var images = [PHAsset]()
    
    // MARK: - Lifecycle
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populatePhotos()
    }
    
    
    // MARK: - Functions
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                // 사진 허용시 갤러리 열기
                let asstes = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                asstes.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                
                self?.images.reverse()
                print(self?.images)
            }
        }
    }
    
}
