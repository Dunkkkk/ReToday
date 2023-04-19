//
//  TodayPhoto.swift
//  
//
//  Created by changgyo seo on 2023/04/15.
//

import UIKit
import Photos

class TodayPhoto {
    
    var id: String
    var image: UIImage
    var asset: PHAsset
    var emoticon: emoticon = .none
    var hasHeart: Bool = false
    var hasCommnet: String = ""
    
    init(id: String, image: UIImage, asset: PHAsset, emoticon: emoticon = .none, hasHeart: Bool = false, hasCommnet: String = "") {
        self.id = id
        self.image = image
        self.asset = asset
        self.emoticon = emoticon
        self.hasHeart = hasHeart
        self.hasCommnet = hasCommnet
    }
}
