extension MinesweeperBoard {
    public struct ViewModel: Codable {
        public var configuration: Configuration

        var cellStates: [CellState]
        var cellConfiguration: MinesweeperCell.Configuration

        public init(configuration: Configuration) {
            self.configuration = configuration

            let cellCount = configuration.width * configuration.height
            self.cellStates = (0..<cellCount).map { _ in CellState.empty }

            self.cellConfiguration = MinesweeperCell.Configuration(
                size: configuration.cellSize,
                fontSize: configuration.fontSize
            )
        }
    }
}
