import XCTest
import SwiftUI
import PreviewSnapshots
import PreviewSnapshotsTesting

import MinesweeperUI
import MinesweeperSDK

final class MinesweeperCellTests: XCTestCase {

    func testAppearance() throws {
        let size = 32.0
        let fontSize = 18.0
        let exposedColor = Color(white: 0.85)
        let unexposedColor = Color(white: 0.94)
        let hintFlagColor = Color(white: 0.85)
        let realFlagColor = Color.red
        let colorMap: [MinesweeperNumber: Color] = [
            .one: Color(red: 0, green: 0, blue: 1),
            .two: Color(red: 0, green: 0.5, blue: 0),
            .three: .red,
            .four: Color(red: 0, green: 0, blue: 0.5),
            .five: Color(red: 0.5, green: 0, blue: 0),
            .six: Color(red: 0, green: 0.5, blue: 0.5),
            .seven: .black,
            .eight: Color(white: 0.5),
        ]

        let snapshots = PreviewSnapshots<MinesweeperCell.Configuration>(
            configurations: [
                .init(name: "exposed_empty", state: .init(size: size, content: .empty, fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_one", state: .init(size: size, content: .number(value: .one, color: colorMap[.one]!), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_two", state: .init(size: size, content: .number(value: .two, color: colorMap[.two]!), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_three", state: .init(size: size, content: .number(value: .three, color: colorMap[.three]!), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_four", state: .init(size: size, content: .number(value: .four, color: colorMap[.four]!), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_five", state: .init(size: size, content: .number(value: .five, color: colorMap[.five]!), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_six", state: .init(size: size, content: .number(value: .six, color: colorMap[.six]!), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_seven", state: .init(size: size, content: .number(value: .seven, color: colorMap[.seven]!), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_eight", state: .init(size: size, content: .number(value: .eight, color: colorMap[.eight]!), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_mine", state: .init(size: size, content: .image(name: "bolt.circle.fill", color: .black), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_selected_mine", state: .init(size: size, content: .image(name: "bolt.circle.fill", color: .black), fontSize: fontSize, background: .red)),
                .init(name: "unexposed_hint_flag", state: .init(size: size, content: .image(name: "flag.fill", color: hintFlagColor), fontSize: fontSize, background: unexposedColor)),
                .init(name: "unexposed_real_flag", state: .init(size: size, content: .image(name: "flag.fill", color: realFlagColor), fontSize: fontSize, background: unexposedColor)),
            ],
            configure: { configuration in
                MinesweeperCell(configuration: configuration)
            }
        )

        snapshots.assertSnapshots()
    }

}
