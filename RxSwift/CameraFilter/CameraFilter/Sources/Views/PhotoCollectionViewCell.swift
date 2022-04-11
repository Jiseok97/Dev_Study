//
//  PhotoCollectionViewCell.swift
//  CameraFilter
//
//  Created by 이지석 on 2022/04/11.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var image = PHAsset()
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    // MARK: - Functions
    
    func configureCell(with image: PHAsset) {
        let manager = PHImageManager.default()
        
        manager.requestImage(for: image , targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
            
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }
        
    }
}
