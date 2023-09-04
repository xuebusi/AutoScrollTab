//
//  Tab.swift
//  AutoScrollTab
//
//  Created by shiyanjun on 2023/9/4.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case men = "Men"
    case woman = "Women"
    case kids = "Kids"
    case living = "Living"
    case game = "Games"
    case outing = "Outing"
    
    func offsetX(_ tabWidth: CGFloat) -> CGFloat {
        let index = Tab.allCases.firstIndex(of: self)! * (-1) + 1
        return CGFloat(index) * tabWidth
    }
}
