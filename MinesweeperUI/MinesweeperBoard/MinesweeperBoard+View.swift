import SwiftUI

extension MinesweeperBoard {
    public struct View: SwiftUI.View {
        public typealias ViewModel = MinesweeperBoard.ViewModel
        typealias CellStateAdapter = MinesweeperBoard.CellStateAdapter

        public typealias CellTapHandler = (_ row: Int, _ col: Int) -> Void

        private let viewModel: ViewModel

        private let onTapCell: CellTapHandler

        public init(viewModel: ViewModel, onTapCell: @escaping CellTapHandler) {
            self.viewModel = viewModel
            self.onTapCell = onTapCell
        }

        public var body: some SwiftUI.View {
            VStack(spacing: 1) {
                ForEach(0..<viewModel.configuration.height, id: \.self) { row in
                    HStack(spacing: 1) {
                        ForEach(0..<viewModel.configuration.width, id: \.self) { col in
                            let cellState = viewModel[row, col]
                            let cellViewModel = MinesweeperCell.ViewModel(
                                configuration: viewModel.cellConfiguration,
                                state: CellStateAdapter(inner: cellState, configuration: viewModel.configuration)
                            )

                            MinesweeperCell.View<CellStateAdapter>(viewModel: cellViewModel)
                                .onTapGesture {
                                    onTapCell(row, col)
                                }
                        }
                    }
                }
            }
            .background(viewModel.configuration.colorSet.boardBackground)
        }
    }
}

#if DEBUG || TEST
private enum PreviewConstants {
    static func makeViewModel() -> MinesweeperBoard.ViewModel {
        let configuration = MinesweeperBoard.Configuration(
            width: 5,
            height: 5,
            cellSize: 32.0,
            fontSize: 18.0,
            imageSet: .init(
                mine: "bolt.circle.fill",
                flag: "flag.fill"
            ),
            colorSet: .init(
                boardBackground: Color(white: 1),
                exposedBackground: Color(white: 0.85),
                unexposedBackground: Color(white: 0.94),
                selectedBackground: Color(red: 1, green: 0, blue: 0),
                numberOne: Color(red: 0, green: 0, blue: 1),
                numberTwo: Color(red: 0, green: 0.5, blue: 0),
                numberThree: Color(red: 1, green: 0, blue: 0),
                numberFour: Color(red: 0, green: 0, blue: 0.5),
                numberFive: Color(red: 0.5, green: 0, blue: 0),
                numberSix: Color(red: 0, green: 0.5, blue: 0.5),
                numberSeven: Color(white: 0),
                numberEight: Color(white: 0.5),
                mine: Color(white: 0),
                realFlag: Color(red: 1, green: 0, blue: 0),
                hintFlag: Color(white: 0.85)
            )
        )
        var viewModel = MinesweeperBoard.ViewModel(configuration: configuration)

        viewModel[0, 0] = MinesweeperBoard.CellState(content: .number(value: .zero), cover: .none)
        viewModel[0, 1] = .init(content: .number(value: .one), cover: .none)
        viewModel[0, 2] = .init(content: .number(value: .two), cover: .none)

        viewModel[1, 0] = .init(content: .number(value: .three), cover: .none)
        viewModel[1, 1] = .init(content: .number(value: .four), cover: .none)
        viewModel[1, 2] = .init(content: .number(value: .five), cover: .none)

        viewModel[2, 0] = .init(content: .number(value: .six), cover: .none)
        viewModel[2, 1] = .init(content: .number(value: .seven), cover: .none)
        viewModel[2, 2] = .init(content: .number(value: .eight), cover: .none)

        viewModel[3, 0] = .init(content: .mine(isSelected: false), cover: .none)
        viewModel[3, 1] = .init(content: .mine(isSelected: true), cover: .none)
        viewModel[3, 2] = .init(content: .number(value: .zero), cover: .block)

        viewModel[4, 0] = .init(content: .number(value: .zero), cover: .hintFlag)
        viewModel[4, 1] = .init(content: .number(value: .zero), cover: .realFlag)

        return viewModel
    }
}

#Preview {
    Group {
        let viewModel = PreviewConstants.makeViewModel()

        ScrollView([.vertical, .horizontal]) {
            MinesweeperBoard.View(viewModel: viewModel) { (row, col) in
                viewModel[row, col].cover = .none
            }
        }
    }
}
#endif
