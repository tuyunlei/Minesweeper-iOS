//
//  MinesweeperCell+Number.swift
//  Minesweeper
//
//  Created by X_Tu on 2024/4/19.
//

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
