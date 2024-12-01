extension MinesweeperCell {
    public struct ViewModel<State: MinesweeperCell.State>: Codable {
        public var configuration: Configuration
        public var state: State

        public init(configuration: Configuration, state: State) {
            self.configuration = configuration
            self.state = state
        }
    }
}
