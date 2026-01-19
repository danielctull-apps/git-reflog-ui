import SwiftUI

extension View {

  func notify<Item, Title: View, Icon: View>(
    with item: Binding<Item?>,
    duration: Double = 0.5,
    label: @escaping (Item) -> Label<Title, Icon>
  ) -> some View {
    modifier(
      NotificationModifier<Item, Title, Icon>(
        item: item,
        duration: duration,
        label: label
      )
    )
  }
}

private struct NotificationModifier<Item, Title: View, Icon: View>: ViewModifier {
  let item: Binding<Item?>
  let duration: TimeInterval
  let label: (Item) -> Label<Title, Icon>

  private func countdown() {
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      item.wrappedValue = nil
    }
  }

  @ViewBuilder
  func body(content: Content) -> some View {
    if let item = item.wrappedValue {
      content
        .overlay(overlay(for: item))
        .onAppear(perform: countdown)
    } else {
      content
    }
  }

  @ViewBuilder
  private func overlay(for item: Item) -> some View {
    label(item)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      .padding(5)
      .foregroundColor(.white)
      .background(RoundedRectangle(cornerRadius: 25).fill(Color.black))
      .padding()
      .transition(.opacity)
  }
}
