import XCTest
import SwiftUI
import PreviewSnapshots
import PreviewSnapshotsTesting

import MinesweeperUI
import MinesweeperSDK

struct EnumMap<Key, Value> where Key: Hashable & CaseIterable {
    typealias InnerDictionary = [Key: Value]

    private var innerDictionary: InnerDictionary = [:]

    init(defaultValueProvider: @escaping (Key) -> Value) {
        Key.allCases.forEach { key in
            let defaultValue = defaultValueProvider(key)
            self.innerDictionary[key] = defaultValue
        }
    }
}

extension EnumMap: Collection {
    typealias Index = Key.AllCases.Index

    var startIndex: Index { Key.allCases.startIndex }

    var endIndex: Index { Key.allCases.endIndex }

    func index(after caseIndex: Index) -> Index {
        Key.allCases.index(after: caseIndex)
    }

    subscript(index: Key.AllCases.Index) -> Value {
        get {
            let key = Key.allCases[index]
            return self[key]
        }
    }

    subscript(key: Key) -> Value {
        get { innerDictionary[key]! }
        set { innerDictionary[key] = newValue }
    }
}

extension EnumMap: Equatable where Value: Equatable {}
extension EnumMap: Hashable where Value: Hashable {}

final class MinesweeperCellTests: XCTestCase {

    func testAppearance() throws {
        let size = 32.0
        let fontSize = 18.0
        let exposedColor = Color(white: 0.85)
        let unexposedColor = Color(white: 0.94)
        let hintFlagColor = Color(white: 0.85)
        let realFlagColor = Color(red: 1, green: 0, blue: 0)
        let colorMap = EnumMap<MinesweeperNumber, Color> {
            switch $0 {
            case .unknown, .zero: Color(white: 0)
            case .one: Color(red: 0, green: 0, blue: 1)
            case .two: Color(red: 0, green: 0.5, blue: 0)
            case .three: Color(red: 1, green: 0, blue: 0)
            case .four: Color(red: 0, green: 0, blue: 0.5)
            case .five: Color(red: 0.5, green: 0, blue: 0)
            case .six: Color(red: 0, green: 0.5, blue: 0.5)
            case .seven: Color(white: 0)
            case .eight: Color(white: 0.5)
            }
        }

        let snapshots = PreviewSnapshots<MinesweeperCell.Configuration>(
            configurations: [
                .init(name: "exposed_empty", state: .init(size: size, content: .empty, fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_one", state: .init(size: size, content: .number(value: .one, color: colorMap[.one]), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_two", state: .init(size: size, content: .number(value: .two, color: colorMap[.two]), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_three", state: .init(size: size, content: .number(value: .three, color: colorMap[.three]), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_four", state: .init(size: size, content: .number(value: .four, color: colorMap[.four]), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_five", state: .init(size: size, content: .number(value: .five, color: colorMap[.five]), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_six", state: .init(size: size, content: .number(value: .six, color: colorMap[.six]), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_seven", state: .init(size: size, content: .number(value: .seven, color: colorMap[.seven]), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_eight", state: .init(size: size, content: .number(value: .eight, color: colorMap[.eight]), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_mine", state: .init(size: size, content: .image(name: "bolt.circle.fill", color: Color(white: 0)), fontSize: fontSize, background: exposedColor)),
                .init(name: "exposed_selected_mine", state: .init(size: size, content: .image(name: "bolt.circle.fill", color: Color(white: 0)), fontSize: fontSize, background: Color(red: 1, green: 0, blue: 0))),
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
