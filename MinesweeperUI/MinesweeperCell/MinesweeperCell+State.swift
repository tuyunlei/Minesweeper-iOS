import SwiftUI

extension MinesweeperCell {
    public protocol State: Codable {
        var content: Content { get }
        var background: Color { get }
    }
}

extension MinesweeperCell {
    public enum Content: Codable {
        case empty
        case number(value: Number, color: Color)
        case image(name: String, color: Color)
    }
}

extension MinesweeperCell.Content {
    public enum Number: Int, Codable, CaseIterable {
        case unknown = -1
        case zero = 0
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8

        public static let min = Self.zero
        public static let max = Self.eight

        public static func from(_ value: Int) -> Self {
            if value >= min.rawValue && value <= max.rawValue {
                Self(rawValue: value)!
            } else {
                Self.unknown
            }
        }

        public var text: String {
            switch self {
            case .unknown: "?"
            default: "\(rawValue)"
            }
        }
    }
}

extension Color: Codable {
    private struct RGBA: Codable {
        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double
    }

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
