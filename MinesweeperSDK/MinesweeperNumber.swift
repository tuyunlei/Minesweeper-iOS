//
//  MinesweeperNumber.swift
//  Minesweeper
//
//  Created by X_Tu on 2024/4/18.
//

public enum MinesweeperNumber: Int, Codable {
    case unknown = -1
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    
    public static let min = Self.zero
    public static let max = Self.eight

    public static func from(_ value: Int) -> MinesweeperNumber {
        if value >= min.rawValue && value <= max.rawValue {
            MinesweeperNumber(rawValue: value)!
        } else {
            MinesweeperNumber.unknown
        }
    }
}
