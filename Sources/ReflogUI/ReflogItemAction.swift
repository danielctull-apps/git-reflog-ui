
import GitKit
import SwiftUI

extension Reflog.Item {

    struct Action: Equatable, Hashable {
        fileprivate let rawValue: String
    }

    var action: Action {
        for kind in Action.allCases {
            if message.hasPrefix(kind.rawValue) { return kind }
        }
        return Action(rawValue: "unknown")
    }
}

extension Reflog.Item.Action {
    static let checkout = Self(rawValue: "checkout")
    static let cherrypick = Self(rawValue: "cherry-pick")
    static let clone = Self(rawValue: "clone")
    static let commit = Self(rawValue: "commit")
    static let merge = Self(rawValue: "merge")
    static let pull = Self(rawValue: "pull")
    static let rebase = Self(rawValue: "rebase")
    static let reset = Self(rawValue: "reset")
}

extension Reflog.Item.Action: Identifiable {
    var id: String { rawValue }
}

extension Reflog.Item.Action: CustomStringConvertible {
    var description: String { rawValue }
}

extension Reflog.Item.Action: CaseIterable {
    static var allCases: [Reflog.Item.Action] {
        [
            .checkout,
            .cherrypick,
            .clone,
            .commit,
            .merge,
            .pull,
            .rebase,
            .reset,
        ]
    }
}

extension Reflog.Item.Action {
    static var maxLength: Int { allCases.map(\.description).map(\.count).reduce(0, max) }
}

extension Reflog.Item.Action {

    var foregroundColor: Color {
        switch self {
        case .checkout: return .black
        case .cherrypick: return .white
        case .clone: return .white
        case .commit: return .black
        case .merge: return .black
        case .pull: return .white
        case .rebase: return .white
        case .reset: return .white
        default: return .white
        }
    }

    var backgroundColor: Color {
        switch self {
        case .checkout: return .blue
        case .cherrypick: return .orange
        case .clone: return .gray
        case .commit: return .green
        case .merge: return .yellow
        case .pull: return .pink
        case .rebase: return .purple
        case .reset: return .red
        default: return .gray
        }
    }

    var trimAmount: Int {
        switch self {
        case .checkout: return 10
        case .cherrypick: return 13
        case .clone: return 7
        case .commit: return 8
        case .merge: return 6
        case .pull: return 5
        case .rebase: return 7
        case .reset: return 7
        default: return 0
        }
    }
}
