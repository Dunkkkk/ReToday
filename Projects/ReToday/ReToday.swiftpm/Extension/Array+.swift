//
//  Array+.swift
//  
//
//  Created by changgyo seo on 2023/04/15.
//

import Combine
import UIKit
import Photos

extension Array where Element == PHAsset {
    
    func changeUIImages(completion: @escaping ([TodayPhoto]) -> () ){
        let dispatchGroup = DispatchGroup()
        var images: [TodayPhoto] = [TodayPhoto]()
        
        for asset in self.enumerated() {
            let imageManager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = false
            requestOptions.deliveryMode = .highQualityFormat
            requestOptions.resizeMode = .fast
            let targetSize = CGSize(width: asset.element.pixelWidth, height: asset.element.pixelHeight)
            dispatchGroup.enter()
            imageManager.requestImage(for: asset.element, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { image, _ in
                if let image = image {
                    images.append(TodayPhoto(id: "\(asset.offset)", image: image, asset: asset.element))
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            // 모든 작업이 완료된 후에 결과를 배열로 묶어서 반환
            completion(images)
        }
    }
}
