
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
        List(reflog) { item in
            HStack {
                Text(item.new.description.dropLast(31))
                Text(item.message)
                Spacer(minLength: 0)
            }
            .font(.system(size: 17, weight: .regular, design: .monospaced))
            .lineLimit(1)
        }
    }
}
