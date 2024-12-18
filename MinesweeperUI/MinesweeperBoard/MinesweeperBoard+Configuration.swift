import SwiftUI
import MinesweeperSDK

extension MinesweeperBoard {
    public struct Configuration: Codable {
        public var width: Int
        public var height: Int
        public var cellSize: CGFloat
        public var fontSize: CGFloat

        public var imageSet: ImageSet
        public var colorSet: ColorSet

        public init(width: Int, height: Int, cellSize: CGFloat, fontSize: CGFloat, imageSet: ImageSet, colorSet: ColorSet) {
            self.width = width
            self.height = height
            self.cellSize = cellSize
            self.fontSize = fontSize
            self.imageSet = imageSet
            self.colorSet = colorSet
        }
    }

    public struct ImageSet: Codable {
        public var mine: String
        public var flag: String

        public init(mine: String, flag: String) {
            self.mine = mine
            self.flag = flag
        }
    }

    public struct ColorSet: Codable {
        public var boardBackground: Color
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

        public init(boardBackground: Color, exposedBackground: Color, unexposedBackground: Color, selectedBackground: Color, numberOne: Color, numberTwo: Color, numberThree: Color, numberFour: Color, numberFive: Color, numberSix: Color, numberSeven: Color, numberEight: Color, mine: Color, realFlag: Color, hintFlag: Color) {
            self.boardBackground = boardBackground
            self.exposedBackground = exposedBackground
            self.unexposedBackground = unexposedBackground
            self.selectedBackground = selectedBackground
            self.numberOne = numberOne
            self.numberTwo = numberTwo
            self.numberThree = numberThree
            self.numberFour = numberFour
            self.numberFive = numberFive
            self.numberSix = numberSix
            self.numberSeven = numberSeven
            self.numberEight = numberEight
            self.mine = mine
            self.realFlag = realFlag
            self.hintFlag = hintFlag
        }
    }
}

extension MinesweeperBoard.ColorSet {
    public func color(for number: MinesweeperCell.Content.Number) -> Color {
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
