//
//  UIScreen.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}

let drawerDefault: [CGFloat] = [(UIScreen.screenHeight * 0.15),
                                (UIScreen.screenHeight * 0.60),
                                (UIScreen.screenHeight * 0.90)]
