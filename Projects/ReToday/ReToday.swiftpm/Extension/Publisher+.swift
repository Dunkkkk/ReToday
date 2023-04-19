//
//  File.swift
//  
//
//  Created by changgyo seo on 2023/04/19.
//

import Combine
import SwiftUI

extension Publishers {
    // 키보드 높이를 전달하는 노티피케이션을 구독하는 Publisher입니다.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0 }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return Publishers.Merge(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
