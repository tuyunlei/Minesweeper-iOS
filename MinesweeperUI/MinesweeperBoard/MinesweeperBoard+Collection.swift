extension MinesweeperBoard.ViewModel: Collection {
    public struct Index: Comparable {
        public let row: Int
        public let col: Int
        public let width: Int

        public var index: Int { row * width + col }

        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.index < rhs.index
        }
    }

    public var startIndex: Index {
        makeIndex(0, 0)
    }

    public var endIndex: Index {
        makeIndex(configuration.height, 0)
    }

    public subscript(position: Index) -> MinesweeperBoard.CellState {
        get { cellStates[position.index] }
        set { cellStates[position.index] = newValue }
    }

    public subscript(row: Int, col: Int) -> MinesweeperBoard.CellState {
        get { self[makeIndex(row, col)] }
        set { self[makeIndex(row, col)] = newValue }
    }

    public func index(after i: Index) -> Index {
        if i.col == configuration.width - 1 {
            makeIndex(i.row + 1, 0)
        } else {
            makeIndex(i.row, i.col + 1)
        }
    }

    private func makeIndex(_ row: Int, _ col: Int) -> Index {
        .init(row: row, col: col, width: configuration.width)
    }
}
