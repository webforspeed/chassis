# Project Configuration
APP_NAME = HelloWorld
BUNDLE_ID = com.example.helloworld
BUILD_DIR = Build
APP_BUNDLE = $(BUILD_DIR)/$(APP_NAME).app
CONTENTS = $(APP_BUNDLE)/Contents
MACOS_DIR = $(CONTENTS)/MacOS
RESOURCES_DIR = $(CONTENTS)/Resources

# Source files
SWIFT_SOURCES = Sources/*.swift

# Compiler flags
SWIFT_FLAGS = -O -whole-module-optimization
FRAMEWORKS = -framework Cocoa -framework WebKit

# Default target
all: build

# Create app bundle structure
bundle-structure:
	@mkdir -p $(MACOS_DIR)
	@mkdir -p $(RESOURCES_DIR)

# Compile Swift sources
compile: bundle-structure
	@echo "Compiling Swift sources..."
	@swiftc $(SWIFT_SOURCES) $(FRAMEWORKS) $(SWIFT_FLAGS) -o $(MACOS_DIR)/$(APP_NAME)

# Copy resources
copy-resources:
	@echo "Copying resources..."
	@cp Resources/Info.plist $(CONTENTS)/
	@cp -r WebContent $(RESOURCES_DIR)/

# Build the app
build: compile copy-resources
	@echo "Build complete: $(APP_BUNDLE)"

# Run the app
run: build
	@echo "Launching $(APP_NAME)..."
	@open $(APP_BUNDLE)

# Clean build artifacts
clean:
	@echo "Cleaning..."
	@rm -rf $(BUILD_DIR)

# Install to /Applications
install: build
	@echo "Installing to /Applications..."
	@cp -r $(APP_BUNDLE) /Applications/

# Uninstall from /Applications
uninstall:
	@rm -rf /Applications/$(APP_NAME).app

.PHONY: all bundle-structure compile copy-resources build run clean install uninstall
