//
//  FilterService.swift
//  CameraFilter
//
//  Created by 이지석 on 2022/04/12.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

class FilterService {
    
    // MARK: - Properties
    
    private var context: CIContext
    
    
    // MARK: - Lifecycle
    
    init() {
        self.context = CIContext()
    }
    
    
    // MARK: - Functions
    
    func applyeFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                
                let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                
                completion(processedImage)
                
            }
        }
        
    }
}
