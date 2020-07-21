
import GitKit
import SwiftUI

struct ReflogView: View {

    let repository: Repository
    let reflog: [Reflog.Item]

    @State private var actions: [Reflog.Item.Action] = []

    var filteredItems: [Reflog.Item] {
        guard !actions.isEmpty else { return reflog }
        return reflog.filter { actions.contains($0.action) }
    }

    init(repository: Repository) throws {
        self.repository = repository
        self.reflog = try repository.reflog().items
    }

    var body: some View {
        VStack(spacing: 0) {
            ActionPicker(selection: $actions)
                .padding(.vertical)
            Divider()
            List(filteredItems) { item in
                ReflogItemView(item: item)
            }
            .id(filteredItems)
            Divider()
            Text("showing \(filteredItems.count) of \(reflog.count) reflog items")
                .padding()
        }
    }
}

struct ActionPicker: View {

    @Binding var selection: [Reflog.Item.Action]

    private func toggle(_ action: Reflog.Item.Action) {
        withAnimation {
            if selection.contains(action) {
                selection.removeAll(where: { $0 == action })
            } else {
                selection.append(action)
            }
        }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Space(length: 0)
                ForEach(Reflog.Item.Action.allCases) { action in
                    ActionView(action: action, selected: selection.contains(action))
                        .onTapGesture { toggle(action) }
                }
                Space(length: 0)
            }
        }
    }
}

struct Space: View {
    let length: CGFloat
    var body: some View {
        Color.clear.frame(width: length, height: length)
    }
}

struct ActionView: View {

    let action: Reflog.Item.Action
    let selected: Bool

    @ViewBuilder
    var body: some View {
        if selected {
            Text(action.description)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(action.backgroundColor))
                .foregroundColor(action.foregroundColor)
                .font(.system(size: 17, weight: .regular, design: .monospaced))
        } else {
            Text(action.description)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(action.backgroundColor, lineWidth: 2))
                .font(.system(size: 17, weight: .regular, design: .monospaced))
        }
    }
}
