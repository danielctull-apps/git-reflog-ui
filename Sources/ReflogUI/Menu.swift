
import AppKit

extension NSMenu {

    static var reflogUI: NSMenu {

        let name = ProcessInfo.processInfo.processName

        let app = NSMenuItem()
        app.submenu = NSMenu()
        app.submenu?.items = [
            NSMenuItem(title: "Quit \(name)", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"),
        ]

        let window = NSMenuItem()
        window.submenu = NSMenu(title: "Window")
        window.submenu?.items = [
            NSMenuItem(title: "Close", action: #selector(NSWindow.performClose(_:)), keyEquivalent: "w"),
        ]

        let menu = NSMenu(title: "Main Menu")
        menu.items = [app, window]
        return menu
    }
}
