
import GitKit
import SwiftUI

struct ReflogItemView: View {

    let item: Reflog.Item

    var body: some View {
        HStack {
            ObjectIDView(item: item)
            VStack(alignment: .leading) {
                Text(dateFormatter.string(from: item.committer.date))
                Text(item.message.dropFirst(item.action.trimAmount))
            }
            .padding(5)
            .font(.system(size: 17, weight: .regular, design: .default))
            Spacer(minLength: 0)
        }
        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(item.action.backgroundColor, lineWidth: 2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .lineLimit(1)
    }
}

fileprivate struct ObjectIDView: View {

    let item: Reflog.Item

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.action.description)
            Text(item.new.description.dropLast(40 - Reflog.Item.Action.maxLength))
        }
        .font(.system(size: 17, weight: .regular, design: .monospaced))
        .padding(10)
        .frame(maxHeight: .infinity)
        .background(item.action.backgroundColor)
        .foregroundColor(item.action.foregroundColor)
        .lineLimit(1)
    }
}
