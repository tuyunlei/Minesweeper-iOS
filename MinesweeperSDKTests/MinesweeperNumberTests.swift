//
//  MinesweeperNumberTests.swift
//  MinesweeperTests
//
//  Created by X_Tu on 2024/4/19.
//

import XCTest
@testable import MinesweeperSDK

final class MinesweeperNumberTests: XCTestCase {

    func testMinesweeperNumberFrom() {
        // known numbers
        XCTAssertEqual(MinesweeperNumber.from(0), .zero)
        XCTAssertEqual(MinesweeperNumber.from(1), .one)
        XCTAssertEqual(MinesweeperNumber.from(2), .two)
        XCTAssertEqual(MinesweeperNumber.from(3), .three)
        XCTAssertEqual(MinesweeperNumber.from(4), .four)
        XCTAssertEqual(MinesweeperNumber.from(5), .five)
        XCTAssertEqual(MinesweeperNumber.from(6), .six)
        XCTAssertEqual(MinesweeperNumber.from(7), .seven)
        XCTAssertEqual(MinesweeperNumber.from(8), .eight)

        // unknown numbers
        XCTAssertEqual(MinesweeperNumber.from(-1), .unknown)
        XCTAssertEqual(MinesweeperNumber.from(10), .unknown)
    }

}
