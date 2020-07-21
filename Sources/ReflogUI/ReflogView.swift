
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
            ForEach(reflog, content: ReflogItemView.init)
            Color.clear
                .frame(width: 0, height: 0)
                .padding(.bottom)
        }
    }
}
