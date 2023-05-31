
import SwiftUI

struct ErrorView: View {

    let error: Error

    var body: some View {
        Text("Error occurred:\n\(error.localizedDescription)")
    }
}
