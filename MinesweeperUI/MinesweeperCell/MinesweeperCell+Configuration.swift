import SwiftUI
import MinesweeperSDK

extension MinesweeperCell {
    public struct Configuration: Codable {
        public var size: CGFloat
        public var content: Content
        public var fontSize: CGFloat
        public var background: Color

        public init(size: CGFloat, content: Content, fontSize: CGFloat, background: Color) {
            self.size = size
            self.content = content
            self.fontSize = fontSize
            self.background = background
        }
    }
}

extension MinesweeperCell.Configuration {
    public enum Content: Codable {
        case empty
        case number(value: MinesweeperNumber, color: Color)
        case image(name: String, color: Color)
    }
}

private struct RGBA: Codable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}

extension Color: Codable {
    private var rgba: RGBA {
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
