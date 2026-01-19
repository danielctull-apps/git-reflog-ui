import AppKit
import Git
import SwiftUI

struct ReflogView: View {

  let repository: Repository
  let reflog: [Reflog.Item]

  @State private var actions: [Reflog.Item.Action] = []
  @State private var search = ""

  var filteredItems: [Reflog.Item] {

    var filteredItems = reflog

    if !search.isEmpty {
      filteredItems = filteredItems.filter { $0.message.contains(search) }
    }

    if !actions.isEmpty {
      filteredItems = filteredItems.filter { actions.contains($0.action) }
    }

    return filteredItems
  }

  init(repository: Repository) throws {
    self.repository = repository
    self.reflog = try Array(repository.reflog.items)
  }

  var body: some View {
    VStack(spacing: 0) {
      TextField("Filter", text: $search)
        .font(.system(size: 17, weight: .regular, design: .default))
        .padding()
      ActionPicker(selection: $actions)
        .padding(.bottom)
      Divider()
      List(filteredItems) { item in
        ReflogItemView(item: item)
      }
      .buttonStyle(OpacityButtonStyle())
      .id(filteredItems)
      Divider()
      Text("showing \(filteredItems.count) of \(reflog.count) reflog items")
        .padding()
    }
  }
}

extension NSPasteboard {

  func copy(_ item: Reflog.Item?) {
    guard let item = item else { return }
    declareTypes([.string], owner: nil)
    setString(item.new.description, forType: .string)
  }
}

struct OpacityButtonStyle: ButtonStyle {

  @ViewBuilder
  func makeBody(configuration: Configuration) -> some View {
    configuration.label.opacity(configuration.isPressed ? 0.7 : 1)
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
          Button(action.description, action: { toggle(action) })
            .buttonStyle(
              ActionButtonStyle(
                selected: selection.contains(action),
                foreground: action.foregroundColor,
                background: action.backgroundColor
              )
            )
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

struct ActionButtonStyle: ButtonStyle {

  let selected: Bool
  let foreground: Color
  let background: Color

  @ViewBuilder
  func makeBody(configuration: Configuration) -> some View {
    if selected {
      configuration.label
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 8).fill(background))
        .foregroundColor(foreground)
        .font(.system(size: 17, weight: .regular, design: .monospaced))
    } else {
      configuration.label
        .padding(8)
        .background(
          RoundedRectangle(cornerRadius: 8).strokeBorder(
            background,
            lineWidth: 2
          )
        )
        .font(.system(size: 17, weight: .regular, design: .monospaced))
    }
  }
}
