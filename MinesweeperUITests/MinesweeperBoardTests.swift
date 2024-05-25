import XCTest
import SwiftUI
import PreviewSnapshots
import PreviewSnapshotsTesting

import MinesweeperUI
import MinesweeperSDK

final class MinesweeperBoardTests: XCTestCase {

    func testAppearance() throws {
        var configuration = MinesweeperBoard.Configuration(
            width: 3,
            height: 5,
            cellSize: 32.0,
            fontSize: 18.0,
            imageSet: .init(
                mine: "bolt.circle.fill",
                flag: "flag.fill"
            ),
            colorSet: .init(
                exposedBackground: Color(white: 0.85),
                unexposedBackground: Color(white: 0.94),
                selectedBackground: .red,
                numberOne: Color(red: 0, green: 0, blue: 1),
                numberTwo: Color(red: 0, green: 0.5, blue: 0),
                numberThree: .red,
                numberFour: Color(red: 0, green: 0, blue: 0.5),
                numberFive: Color(red: 0.5, green: 0, blue: 0),
                numberSix: Color(red: 0, green: 0.5, blue: 0.5),
                numberSeven: .black,
                numberEight: Color(white: 0.5),
                mine: .black,
                realFlag: .red,
                hintFlag: Color(white: 0.85)
            )
        )

        configuration[0, 0] = .init(content: .number(value: .zero), cover: .none)
        configuration[0, 1] = .init(content: .number(value: .one), cover: .none)
        configuration[0, 2] = .init(content: .number(value: .two), cover: .none)

        configuration[1, 0] = .init(content: .number(value: .three), cover: .none)
        configuration[1, 1] = .init(content: .number(value: .four), cover: .none)
        configuration[1, 2] = .init(content: .number(value: .five), cover: .none)

        configuration[2, 0] = .init(content: .number(value: .six), cover: .none)
        configuration[2, 1] = .init(content: .number(value: .seven), cover: .none)
        configuration[2, 2] = .init(content: .number(value: .eight), cover: .none)

        configuration[3, 0] = .init(content: .mine(isSelected: false), cover: .none)
        configuration[3, 1] = .init(content: .mine(isSelected: true), cover: .none)
        configuration[3, 2] = .init(content: .number(value: .zero), cover: .block)

        configuration[4, 0] = .init(content: .number(value: .zero), cover: .hintFlag)
        configuration[4, 1] = .init(content: .number(value: .zero), cover: .realFlag)

        let snapshots = PreviewSnapshots<MinesweeperBoard.Configuration>(
            configurations: [
                .init(name: "board", state: configuration)
            ],
            configure: {
                MinesweeperBoard(configuration: $0) { _, _ in }
            }
        )

        snapshots.assertSnapshots()
    }

}
