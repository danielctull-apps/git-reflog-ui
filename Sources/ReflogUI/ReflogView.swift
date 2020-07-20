
import Foundation
import GitKit
import SwiftUI

let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeStyle = .short
    df.dateStyle = .long
    return df
}()

struct ReflogView: View {

    let repository: Repository
    let reflog: [Reflog.Item]

    init(repository: Repository) throws {
        self.repository = repository
        self.reflog = try repository.reflog().items
    }

    var body: some View {
        List(reflog, rowContent: ItemView.init)
    }
}

struct ItemView: View {

    let item: Reflog.Item

    var body: some View {
        HStack {
            ObjectIDView(item: item)
            VStack(alignment: .leading) {
                Text(dateFormatter.string(from: item.committer.date))
                Text(item.message.dropFirst(item.kind.trimAmount))
            }
            .padding(5)
            .font(.system(size: 17, weight: .regular, design: .default))
            Spacer(minLength: 0)
        }
        .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 4).foregroundColor(item.kind.backgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .lineLimit(1)
    }
}

struct ObjectIDView: View {

    let item: Reflog.Item

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.kind.rawValue)
            Text(item.new.description.dropLast(40 - Reflog.Item.Kind.maxLength))
        }
        .font(.system(size: 17, weight: .regular, design: .monospaced))
        .padding(10)
        .frame(maxHeight: .infinity)
        .background(item.kind.backgroundColor)
        .foregroundColor(item.kind.foregroundColor)
        .lineLimit(1)
    }
}

extension Reflog.Item {

    enum Kind: String, CaseIterable {
        case pull = "pull"
        case commit = "commit"
        case checkout = "checkout"
        case reset = "reset"
        case rebase = "rebase"
        case cherrypick = "cherry-pick"
        case merge = "merge"
        case unknown = ""

        static var maxLength: Int { allCases.map(\.rawValue).map(\.count).reduce(0, max) }

        var foregroundColor: Color {
            switch self {
            case .pull: return .white
            case .commit: return .black
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
            case .reset: return 7
            case .rebase: return 7
            case .cherrypick: return 13
            case .merge: return 6
            case .unknown: return 0
            }
        }
    }

    var kind: Kind {
        for kind in Kind.allCases {
            if message.hasPrefix(kind.rawValue) { return kind }
        }
        return .unknown
    }
}
