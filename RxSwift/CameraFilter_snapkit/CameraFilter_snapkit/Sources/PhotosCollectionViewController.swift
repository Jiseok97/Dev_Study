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
import RxSwift
import RxCocoa

private let reuseIdentifier = "PhotoCollectionViewCell"

protocol PhotosDelegate : class {
    func handleFetchImage()
}

class PhotosCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    weak var delegate: PhotosDelegate?
    
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
        
        configureUI()
        populatePhotos()
    }
    
    
    // MARK: - Functions
    
    private func configureUI() {
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                // 사진 허용시 갤러리 열기
                let asstes = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                asstes.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse()
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: UICollectionView
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { fatalError("PhotoCollectionViewCell을 찾지 못했습니다.") }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: CGSize(width:  100, height: 100),
                                contentMode: .aspectFit, options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped")
        let seletedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: seletedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in
            
            guard let info = info else { return }
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            // 저품질 이미지가 아닐 경우
            if !isDegradedImage {
                if let image = image {
                    self?.delegate?.handleFetchImage()
                    self?.selectedPhotoSubject.onNext(image)
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
