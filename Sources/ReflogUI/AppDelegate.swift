// Inspired by Chris Eidhof
// https://gist.github.com/chriseidhof/26768f0b63fa3cdf8b46821e099df5ff

import AppKit
import SwiftUI

final class AppDelegate<Content: View>: NSObject, NSApplicationDelegate,
  NSWindowDelegate
{

  let content: Content
  var window: NSWindow?

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  func applicationShouldTerminateAfterLastWindowClosed(
    _ sender: NSApplication
  ) -> Bool {
    true
  }

  func applicationDidFinishLaunching(_ notification: Notification) {

    window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
      styleMask: [
        .closable,
        .fullSizeContentView,
        .miniaturizable,
        .resizable,
        .titled,
      ],
      backing: .buffered,
      defer: false
    )
    window?.center()
    window?.contentView = NSHostingView(rootView: content)
    window?.makeKeyAndOrderFront(nil)
    window?.delegate = self
    window?.toolbar?.isVisible = true

    NSApp.activate(ignoringOtherApps: true)
  }
}
