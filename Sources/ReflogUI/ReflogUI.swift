
import AppKit
import AsyncView
import Git
import SwiftUI

@main
struct ReflogUI {

    static func main() {

        let app = NSApplication.shared
        NSApp.setActivationPolicy(.accessory)

        let delegate = AppDelegate {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                AsyncView(
                    task: fetchReflog,
                    success: ReflogView.init,
                    failure: ErrorView.init)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        app.delegate = delegate
        app.menu = .reflogUI
        app.run()
    }
}

func fetchReflog() async throws -> (Repository, [Reflog.Item]) {

    guard let url = Process().currentDirectoryURL else {
        struct CannotFindCurrentDirectoryURL: Error {}
        throw CannotFindCurrentDirectoryURL()
    }

    let repository = try await Repository(url: url)
    let reflog = try await repository.reflog.items
    return (repository, reflog)
}
