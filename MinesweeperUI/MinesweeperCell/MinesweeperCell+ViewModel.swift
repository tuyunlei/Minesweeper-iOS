//
//  MinesweeperCell+Configuration.swift
//  Minesweeper
//
//  Created by X_Tu on 2024/4/18.
//

import SwiftUI
import MinesweeperSDK

public extension MinesweeperCell {
    struct Configuration: Codable {
        let size: CGFloat
        let content: Content
        let fontSize: CGFloat
        let background: Color

        public init(size: CGFloat, content: Content, fontSize: CGFloat, background: Color) {
            self.size = size
            self.content = content
            self.fontSize = fontSize
            self.background = background
        }
    }
}

public extension MinesweeperCell.Configuration {
    enum Content: Codable {
        case empty
        case number(value: MinesweeperNumber, Color: Color)
        case image(name: String, color: Color)
    }
}

struct RGBA: Codable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}

extension Color: Codable {
    var rgba: RGBA {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return RGBA(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }

    public init(from decoder: Decoder) throws {
        let rgba = try RGBA(from: decoder)
        self = Color(red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }

    public func encode(to encoder: Encoder) throws {
        try rgba.encode(to: encoder)
    }

}
