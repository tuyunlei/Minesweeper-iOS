extension MinesweeperBoard.Configuration: Collection {
    public struct Index: Comparable {
        public let row: Int
        public let col: Int
        public let width: Int

        public var index: Int { row * width + col }

        public static func < (lhs: MinesweeperBoard.Configuration.Index, rhs: MinesweeperBoard.Configuration.Index) -> Bool {
            lhs.index < rhs.index
        }
    }

    public var startIndex: Index {
        makeIndex(0, 0)
    }

    public var endIndex: Index {
        makeIndex(height, 0)
    }

    public subscript(position: Index) -> MinesweeperBoard.Cell {
        get { cells[position.index] }
        set { cells[position.index] = newValue }
    }
    
    public subscript(row: Int, col: Int) -> MinesweeperBoard.Cell {
        get { self[makeIndex(row, col)] }
        set { self[makeIndex(row, col)] = newValue }
    }

    public func index(after i: Index) -> Index {
        if i.col == width - 1 {
            makeIndex(i.row + 1, 0)
        } else {
            makeIndex(i.row, i.col + 1)
        }
    }

    private func makeIndex(_ row: Int, _ col: Int) -> Index {
        .init(row: row, col: col, width: width)
    }
}
