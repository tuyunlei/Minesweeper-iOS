import SwiftUI

public struct MinesweeperBoard: View {
    public let configuration: Configuration

    public var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<configuration.height, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(0..<configuration.width, id: \.self) { col in
                        let configuration = makeCellConfiguration(row: row, col: col)

                        MinesweeperCell(configuration: configuration)
                    }
                }
            }
        }
    }

    private func makeCellConfiguration(row: Int, col: Int) -> MinesweeperCell.Configuration {
        let cell = configuration[row, col]

        let content: MinesweeperCell.Configuration.Content =
            switch cell.cover {
            case .none:
                switch cell.content {
                case .number(.zero):
                    .empty
                case .number(let value):
                    .number(value: value, color: configuration.colorSet.color(for: value))
                case .mine(_):
                    .image(name: configuration.imageSet.mine, color: configuration.colorSet.mine)
                }
            case .block:
                .empty
            case .realFlag:
                .image(name: configuration.imageSet.flag, color: configuration.colorSet.realFlag)
            case .hintFlag:
                .image(name: configuration.imageSet.flag, color: configuration.colorSet.hintFlag)
            }

        let background: Color =
        switch cell.cover {
        case .none:
            switch cell.content {
            case .number, .mine(isSelected: false): configuration.colorSet.exposedBackground
            case .mine(isSelected: true):
                configuration.colorSet.selectedBackground
            }

        case .block, .realFlag, .hintFlag: configuration.colorSet.unexposedBackground
        }

        return .init(
            size: configuration.cellSize,
            content: content,
            fontSize: configuration.fontSize,
            background: background
        )
    }
}

#if DEBUG || TEST
import MinesweeperSDK

struct MinesweeperBoard_Previews: PreviewProvider, View {
    static var previews: some View {
        Self()
    }

    static func makeConfiguration() -> MinesweeperBoard.Configuration {
        var configuration = MinesweeperBoard.Configuration(
            width: 5,
            height: 5,
            cellSize: 32.0,
            fontSize: 18.0,
            imageSet: .init(
                mine: "bolt.circle.fill",
                flag: "flag.fill"
            ),
            colorSet: .init(
                exposedBackground: Color(white: 0.85),
                unexposedBackground: Color(white: 0.94),
                selectedBackground: .red,
                numberOne: Color(red: 0, green: 0, blue: 1),
                numberTwo: Color(red: 0, green: 0.5, blue: 0),
                numberThree: .red,
                numberFour: Color(red: 0, green: 0, blue: 0.5),
                numberFive: Color(red: 0.5, green: 0, blue: 0),
                numberSix: Color(red: 0, green: 0.5, blue: 0.5),
                numberSeven: .black,
                numberEight: Color(white: 0.5),
                mine: .black,
                realFlag: .red,
                hintFlag: Color(white: 0.85)
            )
        )

        configuration[0, 0] = .init(content: .number(value: .zero), cover: .none)
        configuration[0, 1] = .init(content: .number(value: .one), cover: .none)
        configuration[0, 2] = .init(content: .number(value: .two), cover: .none)
        
        configuration[1, 0] = .init(content: .number(value: .three), cover: .none)
        configuration[1, 1] = .init(content: .number(value: .four), cover: .none)
        configuration[1, 2] = .init(content: .number(value: .five), cover: .none)
        
        configuration[2, 0] = .init(content: .number(value: .six), cover: .none)
        configuration[2, 1] = .init(content: .number(value: .seven), cover: .none)
        configuration[2, 2] = .init(content: .number(value: .eight), cover: .none)

        configuration[3, 0] = .init(content: .mine(isSelected: false), cover: .none)
        configuration[3, 1] = .init(content: .mine(isSelected: true), cover: .none)
        configuration[3, 2] = .init(content: .number(value: .zero), cover: .block)
        
        configuration[4, 0] = .init(content: .number(value: .zero), cover: .hintFlag)
        configuration[4, 1] = .init(content: .number(value: .zero), cover: .realFlag)

        return configuration
    }

    @State var configuration = makeConfiguration()

    var body: some View {
        MinesweeperBoard(configuration: configuration)
    }
}
#endif
