//
//  String+.swift
//  
//
//  Created by changgyo seo on 2023/04/15.
//

import UIKit
import Combine
import Photos

extension PHAsset {
    
//    func create() -> AnyPublisher<TodayPhoto, Never> {
//        
//        return Future<TodayPhoto, Never> { promise in
//            let imageManager = PHImageManager.default()
//            let requestOptions = PHImageRequestOptions()
//            requestOptions.isSynchronous = false
//            requestOptions.deliveryMode = .highQualityFormat
//            requestOptions.resizeMode = .fast
//            
//            let targetSize = CGSize(width: self.pixelWidth, height: self.pixelHeight)
//            imageManager.requestImage(for: self, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { image, _ in
//                promise(.success(TodayPhoto(image: image ?? UIImage(), asset: self)))
//            }
//        }.eraseToAnyPublisher()
//    }
    
    func addHeart() -> AnyPublisher<Bool, Never> {
        
        Future<Bool, Never> { promise in
            PHPhotoLibrary.shared().performChanges({
                let assetChangeRequest = PHAssetChangeRequest(for: self)
                assetChangeRequest.isFavorite = true
            }) { success, error in
                if success {
                    promise(.success(true))
                }
                else if let error = error {
                    promise(.success(false))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
