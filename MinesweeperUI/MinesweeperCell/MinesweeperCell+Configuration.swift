import SwiftUI
import MinesweeperSDK

extension MinesweeperCell {
    public struct Configuration: Codable {
        public var size: CGFloat
        public var fontSize: CGFloat

        public init(size: CGFloat, fontSize: CGFloat) {
            self.size = size
            self.fontSize = fontSize
        }
    }
}
