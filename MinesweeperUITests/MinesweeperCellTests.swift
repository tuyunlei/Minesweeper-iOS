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

private class CellState: MinesweeperCell.State {
    var content: MinesweeperCell.Content
    var background: Color

    init(content: MinesweeperCell.Content, background: Color) {
        self.content = content
        self.background = background
    }
}

final class MinesweeperCellTests: XCTestCase {

#if os(iOS)
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
        let configuration = MinesweeperCell.Configuration(size: size, fontSize: fontSize)

        let snapshots = PreviewSnapshots<(MinesweeperCell.Content, Color)>(
            configurations: [
                .init(name: "exposed_empty", state: (.empty, exposedColor)),
                .init(name: "exposed_one", state: (.number(value: .one, color: colorMap[.one]), exposedColor)),
                .init(name: "exposed_two", state: (.number(value: .two, color: colorMap[.two]), exposedColor)),
                .init(name: "exposed_three", state: (.number(value: .three, color: colorMap[.three]), exposedColor)),
                .init(name: "exposed_four", state: (.number(value: .four, color: colorMap[.four]), exposedColor)),
                .init(name: "exposed_five", state: (.number(value: .five, color: colorMap[.five]), exposedColor)),
                .init(name: "exposed_six", state: (.number(value: .six, color: colorMap[.six]), exposedColor)),
                .init(name: "exposed_seven", state: (.number(value: .seven, color: colorMap[.seven]), exposedColor)),
                .init(name: "exposed_eight", state: (.number(value: .eight, color: colorMap[.eight]), exposedColor)),
                .init(name: "exposed_mine", state: (.image(name: "bolt.circle.fill", color: Color(white: 0)), exposedColor)),
                .init(name: "exposed_selected_mine", state: (.image(name: "bolt.circle.fill", color: Color(white: 0)), Color(red: 1, green: 0, blue: 0))),
                .init(name: "unexposed_hint_flag", state: (.image(name: "flag.fill", color: hintFlagColor), unexposedColor)),
                .init(name: "unexposed_real_flag", state: (.image(name: "flag.fill", color: realFlagColor), unexposedColor)),
            ],
            configure: { (content, background) in
                MinesweeperCell.View(viewModel: .init(
                    configuration: configuration,
                    state: CellState(content: content, background: background)
                ))
            }
        )

        snapshots.assertSnapshots(as: .image(precision: 0.97))
    }
#endif

}
