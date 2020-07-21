
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
        List {
            Color.clear
                .frame(width: 0, height: 0)
                .padding(.top)
            ForEach(reflog, content: ItemView.init)
            Color.clear
                .frame(width: 0, height: 0)
                .padding(.bottom)
        }
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
        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 4).foregroundColor(item.kind.backgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .lineLimit(1)
        .padding(.horizontal)
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
