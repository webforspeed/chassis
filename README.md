# Webforspeed Chasis

A bare-bones macOS application built with Swift and WKWebView that demonstrates bidirectional communication between JavaScript and Swift. This is the absolute minimal implementation with the fewest lines of code possible.

## Project Structure

```
.
├── Makefile                    # Build system
├── Sources/                    # Swift backend
│   ├── main.swift             # Entry point
│   ├── AppDelegate.swift      # App lifecycle
│   └── WebViewController.swift # WKWebView + JS bridge
├── WebContent/                 # Web frontend
│   ├── index.html             
│   ├── app.js                 
│   └── styles.css             
├── Resources/
│   └── Info.plist             # App metadata
└── Build/
    └── HelloWorld.app         # Generated app bundle
```

## Requirements

- macOS 10.15 or later
- Xcode Command Line Tools (for `swiftc` compiler)

To install Command Line Tools:
```bash
xcode-select --install
```

## Quick Start

### Build and Run

```bash
# Build and launch the app
make run
```

### Other Commands

```bash
# Just build (creates Build/HelloWorld.app)
make build

# Clean build artifacts
make clean

# Install to /Applications
make install

# Remove from /Applications
make uninstall
```

