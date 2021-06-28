
import SwiftUI

struct Notification2 {
    let icon: Image
    let title: Text
}

extension Notification2 {
    init(title: String, systemName: String) {
        self.init(icon: Image(systemName: systemName), title: Text(title))
    }
}

extension View {

    func notify<Item>(
        with item: Binding<Item?>,
        duration: Double = 0.5,
        notification: @escaping (Item) -> Notification2
    ) -> some View {
        modifier(
            NotificationModifier<Item>(
                item: item,
                duration: duration,
                notification: notification
            )
        )
    }
}

fileprivate struct NotificationModifier<Item> {
    let item: Binding<Item?>
    let duration: Double
    let notification: (Item) -> Notification2
}

extension NotificationModifier: ViewModifier {

    func countdown() {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            item.wrappedValue = nil
        }
    }

    @ViewBuilder
    func body(content: Content) -> some View {
        if let item = item.wrappedValue {
            content
                .overlay(NotificationView(notification: notification(item)))
                .onAppear(perform: countdown)
        } else {
            content
        }
    }
}

struct NotificationView: View {
    let notification: Notification2
    
    var body: some View {

        HStack {
            notification.icon
            notification.title
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(5)
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 25).fill(Color.black))
        .padding()
        .transition(.opacity)
    }
}
