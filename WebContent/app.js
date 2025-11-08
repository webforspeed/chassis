function sendToSwift() {
    window.webkit.messageHandlers.bridge.postMessage("World");
}

window.handleSwiftMessage = function(message) {
    document.getElementById('response').textContent = message;
}
