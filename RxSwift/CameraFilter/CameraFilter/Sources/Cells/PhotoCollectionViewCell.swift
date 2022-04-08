//
//  PhotoCollectionViewCell.swift
//  CameraFilter
//
//  Created by 이지석 on 2022/04/08.
//

import Foundation
import Photos
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    
//    func configureCell(with asset: PHAsset) {
//        let manager = PHImageManager.default()
//        
//        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
//            DispatchQueue.main.async {
//                self.photoImageView.image = image
//            }
//        }
//    }
    
}
