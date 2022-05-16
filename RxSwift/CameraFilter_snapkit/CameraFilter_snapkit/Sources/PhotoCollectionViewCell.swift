//
//  PhotosCollectionViewCell.swift
//  CameraFilter_snapkit
//
//  Created by 이지석 on 2022/05/16.
//

import Foundation
import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    
    lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    
    private func configureCell() {
        contentView.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
}
