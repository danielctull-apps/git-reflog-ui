
import Foundation
import GitKit
import SwiftUI

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
            Text(item.new.description.dropLast(31))
            Text(item.message)
            Spacer(minLength: 0)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 5).fill(item.backgroundColor))
        .foregroundColor(item.foregroundColor)
        .font(.system(size: 17, weight: .regular, design: .monospaced))
        .lineLimit(1)
    }
}

extension Reflog.Item {

    private static let actions: [(name: String, foreground: Color, background: Color)] = [
        ("pull", .white, .pink),
        ("commit", .black, .green),
        ("checkout", .black, .blue),
        ("reset", .white, .red),
        ("rebase", .white, .purple),
        ("cherry-pick", .white, .orange),
        ("merge", .black, .yellow),
    ]

    var backgroundColor: Color {

        for action in Reflog.Item.actions {
            if message.hasPrefix(action.name) { return action.background }
        }

        return .gray
    }

    var foregroundColor: Color {

        for action in Reflog.Item.actions {
            if message.hasPrefix(action.name) { return action.foreground }
        }

        return .white
    }
}
