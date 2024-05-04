import SwiftUI
import MinesweeperSDK

extension MinesweeperBoard {
    public struct Cell: Codable {
        public var content: Content
        public var cover: Cover
    }

    public struct Configuration: Codable {
        public var width: Int
        public var height: Int
        public var cellSize: CGFloat
        public var fontSize: CGFloat
        
        public var imageSet: ImageSet
        public var colorSet: ColorSet

        internal var cells: [Cell]

        public init(width: Int, height: Int, cellSize: CGFloat, fontSize: CGFloat, imageSet: ImageSet, colorSet: ColorSet) {
            self.width = width
            self.height = height
            self.cellSize = cellSize
            self.fontSize = fontSize
            self.imageSet = imageSet
            self.colorSet = colorSet

            self.cells = Array(repeating: .empty, count: width * height)
        }
    }
    
    public struct ImageSet: Codable {
        public var mine: String
        public var flag: String
    }

    public struct ColorSet: Codable {
        public var exposedBackground: Color
        public var unexposedBackground: Color
        public var selectedBackground: Color

        public var numberOne: Color
        public var numberTwo: Color
        public var numberThree: Color
        public var numberFour: Color
        public var numberFive: Color
        public var numberSix: Color
        public var numberSeven: Color
        public var numberEight: Color

        public var mine: Color

        public var realFlag: Color
        public var hintFlag: Color
    }
}

extension MinesweeperBoard.Cell {
    public enum Content: Codable {
        case mine(isSelected: Bool)
        case number(value: MinesweeperNumber)
    }

    public enum Cover: Codable {
        case none
        case block
        case realFlag
        case hintFlag
    }
    
    internal static let empty = Self(content: .number(value: .zero), cover: .block)
}

extension MinesweeperBoard.ColorSet {
    public func color(for number: MinesweeperNumber) -> Color {
        switch number {
        case .unknown, .zero: .white
        case .one: numberOne
        case .two: numberTwo
        case .three: numberThree
        case .four: numberFour
        case .five: numberFive
        case .six: numberSix
        case .seven: numberSeven
        case .eight: numberEight
        }
    }
}
