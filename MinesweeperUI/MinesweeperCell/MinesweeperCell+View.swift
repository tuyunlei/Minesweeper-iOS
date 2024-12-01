import SwiftUI

extension MinesweeperCell {
    public struct View<State: MinesweeperCell.State>: SwiftUI.View {
        public typealias ViewModel = MinesweeperCell.ViewModel
        typealias Configuration = MinesweeperCell.Configuration

        private let viewModel: ViewModel<State>

        private var configuration: Configuration {
            viewModel.configuration
        }

        private var state: State {
            viewModel.state
        }

        public init(viewModel: ViewModel<State>) {
            self.viewModel = viewModel
        }

        public var body: some SwiftUI.View {
            VStack {
                switch state.content {
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
            .background(state.background)
        }
    }
}

#if DEBUG || TEST
@Observable
private class PreviewCellState: MinesweeperCell.State {
    var content: MinesweeperCell.Content
    var background: Color

    init(content: MinesweeperCell.Content, background: Color) {
        self.content = content
        self.background = background
    }
}

private enum PreviewConstants {
    static let size = 32.0
    static let fontSize = 18.0
    static let exposedColor = Color(white: 0.85)
    static let unexposedColor = Color(white: 0.94)
    static let hintFlagColor = Color(white: 0.85)
    static let realFlagColor = Color.red
    static let colorMap: [MinesweeperCell.Content.Number: Color] = [
        .one: Color(red: 0, green: 0, blue: 1),
        .two: Color(red: 0, green: 0.5, blue: 0),
        .three: .red,
        .four: Color(red: 0, green: 0, blue: 0.5),
        .five: Color(red: 0.5, green: 0, blue: 0),
        .six: Color(red: 0, green: 0.5, blue: 0.5),
        .seven: .black,
        .eight: Color(white: 0.5),
    ]

    static let configuration = MinesweeperCell.Configuration(size: size, fontSize: fontSize)
    static let stateGrid: [[PreviewCellState]] = [
        [
            .init(content: .empty, background: exposedColor),
            .init(content: .number(value: .one, color: colorMap[.one]!), background: exposedColor),
            .init(content: .number(value: .two, color: colorMap[.two]!), background: exposedColor),
        ],
        [
            .init(content: .number(value: .three, color: colorMap[.three]!), background: exposedColor),
            .init(content: .number(value: .four, color: colorMap[.four]!), background: exposedColor),
            .init(content: .number(value: .five, color: colorMap[.five]!), background: exposedColor),
        ],
        [
            .init(content: .number(value: .six, color: colorMap[.six]!), background: exposedColor),
            .init(content: .number(value: .seven, color: colorMap[.seven]!), background: exposedColor),
            .init(content: .number(value: .eight, color: colorMap[.eight]!), background: exposedColor),
        ],
        [
            .init(content: .image(name: "bolt.circle.fill", color: .black), background: exposedColor),
            .init(content: .image(name: "bolt.circle.fill", color: .black), background: .red),
            .init(content: .image(name: "flag.fill", color: hintFlagColor), background: unexposedColor),
            .init(content: .image(name: "flag.fill", color: realFlagColor), background: unexposedColor),
        ],
    ]
}

#Preview {
    Group {
        let stateGrid: [[PreviewCellState]] = PreviewConstants.stateGrid

        VStack(spacing: 1) {
            ForEach(stateGrid.indices, id: \.self) { row in
                let stateRow = stateGrid[row]

                HStack(spacing: 1) {
                    ForEach(stateRow.indices, id: \.self) { col in
                        let state = stateRow[col]
                        let viewModel = MinesweeperCell.ViewModel(
                            configuration: PreviewConstants.configuration,
                            state: state
                        )

                        MinesweeperCell.View(viewModel: viewModel)
                            .onTapGesture {
                                state.content = .empty
                            }
                    }
                }
            }
        }
    }
}
#endif
