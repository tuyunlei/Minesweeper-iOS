import SwiftUI

extension MinesweeperBoard {

    @Observable
    public class CellState: Codable {
        public var content: Content
        public var cover: Cover

        public init(content: Content, cover: Cover) {
            self.content = content
            self.cover = cover
        }
    }

    struct CellStateAdapter: MinesweeperCell.State, Codable {
        let inner: CellState
        let configuration: Configuration

        var content: MinesweeperCell.Content {
            switch inner.cover {
            case .none:
                switch inner.content {
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
        }

        var background: Color {
            switch inner.cover {
            case .none:
                switch inner.content {
                case .number, .mine(isSelected: false): configuration.colorSet.exposedBackground
                case .mine(isSelected: true):
                    configuration.colorSet.selectedBackground
                }
            case .block, .realFlag, .hintFlag:
                configuration.colorSet.unexposedBackground
            }
        }
    }
}

extension MinesweeperBoard.CellState {
    public enum Content: Codable {
        case mine(isSelected: Bool)
        case number(value: MinesweeperCell.Content.Number)
    }

    public enum Cover: Codable {
        case none
        case block
        case realFlag
        case hintFlag
    }

    internal static var empty: MinesweeperBoard.CellState {
        MinesweeperBoard.CellState(content: .number(value: .zero), cover: .block)
    }
}

