//
//  Color.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 17/3/2567 BE.
//

import SwiftUI

extension Color {
    init(rgb: (Int, Int, Int)) {
        let red = Double(rgb.0) / 255.0
        let green = Double(rgb.1) / 255.0
        let blue = Double(rgb.2) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
