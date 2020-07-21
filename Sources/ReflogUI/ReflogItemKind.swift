
import GitKit
import SwiftUI

extension Reflog.Item {

    var kind: Kind {
        for kind in Kind.allCases {
            if message.hasPrefix(kind.rawValue) { return kind }
        }
        return .unknown
    }

    enum Kind: String, CaseIterable {
        case pull = "pull"
        case commit = "commit"
        case clone = "clone"
        case checkout = "checkout"
        case reset = "reset"
        case rebase = "rebase"
        case cherrypick = "cherry-pick"
        case merge = "merge"
        case unknown = ""
    }
}

extension Reflog.Item.Kind {

    static var maxLength: Int { allCases.map(\.rawValue).map(\.count).reduce(0, max) }

    var foregroundColor: Color {
        switch self {
        case .pull: return .white
        case .commit: return .black
        case .clone: return .white
        case .checkout: return .black
        case .reset: return .white
        case .rebase: return .white
        case .cherrypick: return .white
        case .merge: return .black
        case .unknown: return .white
        }
    }

    var backgroundColor: Color {
        switch self {
        case .pull: return .pink
        case .commit: return .green
        case .clone: return .gray
        case .checkout: return .blue
        case .reset: return .red
        case .rebase: return .purple
        case .cherrypick: return .orange
        case .merge: return .yellow
        case .unknown: return .gray
        }
    }

    var trimAmount: Int {
        switch self {
        case .pull: return 5
        case .commit: return 8
        case .checkout: return 10
        case .clone: return 7
        case .reset: return 7
        case .rebase: return 7
        case .cherrypick: return 13
        case .merge: return 6
        case .unknown: return 0
        }
    }
}
