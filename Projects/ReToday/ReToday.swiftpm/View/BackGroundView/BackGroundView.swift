//
//  BackGroundView.swift
//  
//
//  Created by changgyo seo on 2023/04/16.
//

import SwiftUI

struct BackGroundView<background>: View where background: View {
    
    @Binding var newImage: UIImage
    @Binding var isClosed: Bool
    var backgroundContent: () -> background
    
    
    var body: some View {
        ZStack {
            Image(uiImage: newImage)
                .resizable()
                .frame(width: 567, height: 745)
                .scaledToFit()
            Image("airplane window")
                .offset(y: isClosed ?  0 : -600)
                .animation(.linear(duration: 1.6), value: isClosed)
            Image("background1")
            backgroundContent()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
