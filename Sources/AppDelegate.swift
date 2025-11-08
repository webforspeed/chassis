import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var webViewController: WebViewController!

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSLog("=== App launched ===")

        // Set activation policy first
        NSApp.setActivationPolicy(.regular)
        NSLog("Activation policy set")

        // Create view controller
        webViewController = WebViewController()
        NSLog("WebViewController created")

        // Create a properly sized window and attach the view controller
        let windowRect = NSRect(x: 0, y: 0, width: 960, height: 600)
        window = NSWindow(
            contentRect: windowRect,
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.contentViewController = webViewController
        window.title = "Hello World App"
        window.center()
        window.isOpaque = true
        window.backgroundColor = NSColor.windowBackgroundColor
        NSLog("Window created with rect: %@", NSStringFromRect(windowRect))

        // Make window visible and activate app
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        NSLog("Window visible: %d, frame: %@", window.isVisible, NSStringFromRect(window.frame))
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
