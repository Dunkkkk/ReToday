//
//  File.swift
//  
//
//  Created by changgyo seo on 2023/04/16.
//

import SwiftUI
import Photos

struct Cloud: View {
    
    var image: TodayPhoto
    let onTapGesture: (TodayPhoto, Int) -> Void
    
    var body: some View {
        Image(uiImage: image.image)
            .resizable()
            .frame(width: makeCGSize(image: image.image).width,
                   height: makeCGSize(image: image.image).height)
            .mask {
                ZStack {
                    Ellipse()
                        .frame(width: 319.54, height: 137.98)
                        .foregroundColor(.red)
                    Ellipse()
                        .frame(width: 319.54, height: 137.98)
                        .foregroundColor(.red)
                        .offset(x: 0, y: 72)
                    
                }
                .offset(x: 0, y: -36)
            }
            .clipped()
            .onTapGesture {
                onTapGesture(image, Int(image.id)!)
            }
    }
    
    func makeCGSize(image: UIImage) -> CGSize {
        var width = image.size.width
        var height = image.size.height
        let vector: CGVector = CGVector(dx: width / height, dy: height / width)
        
        width = 0
        height = 0
        while true {
            if height > 215 && width > 319.54 {
                break
            }
            else {
                height += vector.dy
                width += vector.dx
            }
        }
        
        return CGSize(width: width, height: height)
    }
}
