import Foundation
import MinesweeperSDK

extension MinesweeperNumber {
    var text: String {
        switch self {
        case .unknown: "?"
        default: "\(rawValue)"
        }
    }
}
