import SwiftUI
import SwifterSwift
import MinesweeperSDK

public struct MinesweeperCell: View {
    let configuration: Configuration

    public init(configuration: Configuration) {
        self.configuration = configuration
    }

    public var body: some View {
        VStack {
            switch configuration.content {
            case .empty:
                EmptyView()
            case .number(let value, let color):
                Text(value.text)
                    .font(.system(size: configuration.fontSize))
                    .foregroundStyle(color)
            case .image(let name, let color):
                Image(systemName: name)
                    .font(.system(size: configuration.fontSize))
                    .foregroundStyle(color)
            }
        }
        .accessibilityIdentifier("cell")
        .frame(width: configuration.size, height: configuration.size)
        .background(configuration.background)
    }
}

#if DEBUG || TEST
struct MinesweeperCell_Previews: PreviewProvider, View {
    static var previews: some View {
        Self()
    }

    static let size = 32.0
    static let fontSize = 18.0
    static let exposedColor = Color(white: 0.85)
    static let unexposedColor = Color(white: 0.94)
    static let hintFlagColor = Color(white: 0.85)
    static let realFlagColor = Color.red
    static let colorMap: [MinesweeperNumber: Color] = [
        .one: Color(red: 0, green: 0, blue: 1),
        .two: Color(red: 0, green: 0.5, blue: 0),
        .three: .red,
        .four: Color(red: 0, green: 0, blue: 0.5),
        .five: Color(red: 0.5, green: 0, blue: 0),
        .six: Color(red: 0, green: 0.5, blue: 0.5),
        .seven: .black,
        .eight: Color(white: 0.5),
    ]

    static let configurationGrid: [[MinesweeperCell.Configuration]] = [
        [
            .init(size: size, content: .empty, fontSize: fontSize, background: exposedColor),
            .init(size: size, content: .number(value: .one, Color: colorMap[.one]!), fontSize: fontSize, background: exposedColor),
            .init(size: size, content: .number(value: .two, Color: colorMap[.two]!), fontSize: fontSize, background: exposedColor),
        ],
        [
            .init(size: size, content: .number(value: .three, Color: colorMap[.three]!), fontSize: fontSize, background: exposedColor),
            .init(size: size, content: .number(value: .four, Color: colorMap[.four]!), fontSize: fontSize, background: exposedColor),
            .init(size: size, content: .number(value: .five, Color: colorMap[.five]!), fontSize: fontSize, background: exposedColor),
        ],
        [
            .init(size: size, content: .number(value: .six, Color: colorMap[.six]!), fontSize: fontSize, background: exposedColor),
            .init(size: size, content: .number(value: .seven, Color: colorMap[.seven]!), fontSize: fontSize, background: exposedColor),
            .init(size: size, content: .number(value: .eight, Color: colorMap[.eight]!), fontSize: fontSize, background: exposedColor),
        ],
        [
            .init(size: size, content: .image(name: "bolt.circle.fill", color: .black), fontSize: fontSize, background: exposedColor),
            .init(size: size, content: .image(name: "bolt.circle.fill", color: .black), fontSize: fontSize, background: .red),
            .init(size: size, content: .image(name: "flag.fill", color: hintFlagColor), fontSize: fontSize, background: unexposedColor),
            .init(size: size, content: .image(name: "flag.fill", color: realFlagColor), fontSize: fontSize, background: unexposedColor),
        ],
    ]

    var body: some View {
        VStack(spacing: 1) {
            ForEach(Self.configurationGrid.indices, id: \.self) { index in
                let configurationRow = Self.configurationGrid[index]
                HStack(spacing: 1) {
                    ForEach(configurationRow.indices, id: \.self) { index in
                        let configuration = configurationRow[index]
                        MinesweeperCell(configuration: configuration)
                    }
                }
            }
        }
    }
}
#endif
