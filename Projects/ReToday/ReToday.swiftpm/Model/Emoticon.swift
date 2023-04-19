//
//  Emoticon.swift
//  
//
//  Created by changgyo seo on 2023/04/18.
//

enum emoticon: CaseIterable, Identifiable {
    
    case none, one, two, three, four
    
    var image: String {
        switch self {
        case .one:
            return "imo1"
        case .two:
            return "imo2"
        case .three:
            return "imo3"
        case .four:
            return "imo4"
        case .none:
            return "1"
        }
    }
    var id: Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .none:
            return 5
        }
    }
}
