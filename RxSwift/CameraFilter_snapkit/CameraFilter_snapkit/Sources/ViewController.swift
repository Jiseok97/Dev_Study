//
//  ViewController.swift
//  CameraFilter_snapkit
//
//  Created by 이지석 on 2022/05/14.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {

    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    private lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.tintColor = .link
        button.setTitle("Apply", for: .normal)
        button.addTarget(self, action: #selector(handleApply), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        configureUI()
        configureNavigationBar()
    }
    
    // MARK: - Selector
    
    @objc func handleAdd() {
        let photosController = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(photosController, animated: true)
    }
    
    @objc func handleApply() {
        print("DEBUG: Apply button tapped")
    }

    
    // MARK: - Functions
    
    private func configureUI() {
        
        self.view.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(16)
            make.leading.equalTo(self.view).offset(24)
            make.trailing.equalTo(self.view).offset(-24)
            make.height.equalToSuperview().multipliedBy(0.81)
        }
        
        self.view.addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120, height: 42))
            make.top.equalTo(photoImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationItem.title = "Camera Filter"
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .link
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }

}

extension ViewController: PhotosDelegate {
    func handleFetchImage() {
        guard let controller = self.navigationController?.viewControllers.first as? PhotosCollectionViewController else { fatalError("PhotosCollectionViewController를 찾을 수 없습니다.")}
//        let controller = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

        controller.selectedPhoto.subscribe(onNext: { [weak self] photo in
            self?.photoImageView.image = photo
        }).disposed(by: disposeBag)
        
        
    }
}
