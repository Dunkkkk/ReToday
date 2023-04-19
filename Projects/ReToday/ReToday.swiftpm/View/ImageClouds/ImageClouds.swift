//
//  File.swift
//  
//
//  Created by changgyo seo on 2023/04/16.
//

import SwiftUI
import Photos

struct ImageClouds: View {
    
    @State var todayPhotos: [TodayPhoto]
    let items: [item]
    @Namespace private var animation
    @State var animationStart: Bool = false
    @State var addwidth = 0.0
    var callBackMethod: (TodayPhoto, Int) -> Void
    
    
    var body: some View {
        ZStack {
            ForEach(items, id: \.id) { item in
                Cloud(image: item.data) { photo, idx in
                    callBackMethod(photo, idx)
                }
                .position(x: animationStart ? item.initPosition.second.x : item.initPosition.first.x, y: animationStart ? item.initPosition.second.y : item.initPosition.first.y)
                .animation(.linear(duration: 10).repeatForever(), value: animationStart)
            }
        }
        .onAppear {
            animationStart.toggle()
        }
    }
    init(todayPhotos: [TodayPhoto], animationStart: Bool, addwidth: Double = 0.0, callBackMethod: @escaping (TodayPhoto, Int) -> Void) {
        self.todayPhotos = todayPhotos
        self.items = ImageClouds.makeItems(photos: todayPhotos, size: UIScreen.main.bounds.size)
        self.animationStart = animationStart
        self.addwidth = addwidth
        self.callBackMethod = callBackMethod
    }
}


extension ImageClouds {
    
    struct item: Identifiable, Equatable {
        
        static func == (lhs: ImageClouds.item, rhs: ImageClouds.item) -> Bool {
            return lhs.id == rhs.id
        }
        var id: String
        var height: CGFloat = 0.0
        var data: TodayPhoto
        var initPosition: (first: CGPoint, second: CGPoint)
    }
    
    static func makeItems(photos: [TodayPhoto], size: CGSize) -> [item] {
        print("@Log in makeitems")
        var items: [item] = [item]()
        
        for photo in photos {
            let p = ImageClouds.makeRandomPostion(size: size)
            items.append(item(id: photo.id , height: 0, data: photo, initPosition: p))
        }
        return items
    }
    
    static func makeRandomPostion(size: CGSize) -> (first: CGPoint, second: CGPoint) {
        let height = Int(size.height - 150)
        let width = Int(size.width - 150)
        
        let judgment = [0,1].randomElement()
        let judgment2 = [0,1].randomElement()
        if judgment == 0 {
            if judgment2 == 0 {
                return (CGPoint(x: 150, y: (150...height).randomElement()!), CGPoint(x: width, y: (150...height).randomElement()!))
            }
            else {
                return (CGPoint(x: width, y: (150...height).randomElement()!), CGPoint(x: 150, y: (150...height).randomElement()!))
            }
            
        }
        else {
            if judgment2 == 0 {
                return (CGPoint(x: (150...width).randomElement()!, y: 150), CGPoint(x: (150...width).randomElement()!, y: height))
            }
            else {
                return (CGPoint(x: (150...width).randomElement()!, y: height), CGPoint(x: (150...width).randomElement()!, y: 150))
            }
        }
    }
    
}
