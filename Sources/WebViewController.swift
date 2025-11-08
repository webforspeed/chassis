import Cocoa
import WebKit

class WebViewController: NSViewController, WKScriptMessageHandler, WKNavigationDelegate {
    var webView: WKWebView!

    override func loadView() {
        // Create configuration first
        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: "bridge")

        // Enable developer extras for debugging
        config.preferences.setValue(true, forKey: "developerExtrasEnabled")

        // Create webview with proper frame
        webView = WKWebView(frame: NSRect(x: 0, y: 0, width: 960, height: 600), configuration: config)
        webView.navigationDelegate = self

        // Set the webview as the main view
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("=== WebViewController viewDidLoad ===")

        // Load HTML content
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "WebContent") {
            NSLog("Found HTML at: %@", htmlPath)
            let htmlURL = URL(fileURLWithPath: htmlPath)
            let readAccessURL = htmlURL.deletingLastPathComponent()
            NSLog("Read access to: %@", readAccessURL.path)

            webView.loadFileURL(htmlURL, allowingReadAccessTo: readAccessURL)
            NSLog("Loading HTML from file URL...")
        } else {
            NSLog("ERROR: Could not find index.html in WebContent!")
            // List what's actually in Resources
            if let resourcePath = Bundle.main.resourcePath {
                NSLog("Resource path: %@", resourcePath)
                let fileManager = FileManager.default
                if let contents = try? fileManager.contentsOfDirectory(atPath: resourcePath) {
                    NSLog("Resources directory contents: %@", contents.joined(separator: ", "))
                }
            }
        }
    }

    // WKNavigationDelegate methods for debugging
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NSLog("Navigation started")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NSLog("Navigation finished - page loaded successfully!")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        NSLog("Navigation failed: %@", error.localizedDescription)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NSLog("Provisional navigation failed: %@", error.localizedDescription)
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        NSLog("Received message from JavaScript: %@", String(describing: message.body))
        if message.name == "bridge", let body = message.body as? String {
            let response = "Hello \(body) from Swift!"
            webView.evaluateJavaScript("window.handleSwiftMessage('\(response)')") { result, error in
                if let error = error {
                    NSLog("JavaScript evaluation error: %@", error.localizedDescription)
                } else {
                    NSLog("JavaScript executed successfully")
                }
            }
        }
    }

    deinit {
        webView?.configuration.userContentController.removeScriptMessageHandler(forName: "bridge")
    }
}
