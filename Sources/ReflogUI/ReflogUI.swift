
import AppKit
import Git
import SwiftUI

@main
struct ReflogUI {

    static func main() async throws {

        let app = NSApplication.shared
        NSApp.setActivationPolicy(.accessory)
        guard let url = Process().currentDirectoryURL else {
            struct CannotFindCurrentDirectoryURL: Error {}
            throw CannotFindCurrentDirectoryURL()
        }
        let repository = try await Repository(url: url)
        let reflog = try await repository.reflog.items
        let delegate = AppDelegate {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                ReflogView(repository: repository, reflog: reflog)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        app.delegate = delegate
        app.menu = .reflogUI
        app.run()
    }
}
