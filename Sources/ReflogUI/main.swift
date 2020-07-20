
import AppKit
import GitKit
import SwiftUI

let app = NSApplication.shared
NSApp.setActivationPolicy(.accessory)
guard let url = Process().currentDirectoryURL else {
    struct CannotFindCurrentDirectoryURL: Error {}
    throw CannotFindCurrentDirectoryURL()
}
let repository = try Repository(url: url)
let delegate = AppDelegate {
    ZStack {
        Color.white
            .edgesIgnoringSafeArea(.all)
        try! ReflogView(repository: repository)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
app.delegate = delegate
app.run()
