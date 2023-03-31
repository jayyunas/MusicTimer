import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create window
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 200), styleMask: [.titled, .closable, .miniaturizable, .resizable], backing: .buffered, defer: false)
        window.center()
        window.title = "Music Timer"
        window.makeKeyAndOrderFront(nil)

        // Create slider
        let slider = NSSlider(frame: NSRect(x: 10, y: 70, width: 380, height: 20))
        slider.minValue = 1
        slider.maxValue = 60
        slider.intValue = 10
        window.contentView?.addSubview(slider)

        // Create button
        let button = NSButton(frame: NSRect(x: 150, y: 20, width: 100, height: 30))
        button.title = "Start"
        button.bezelStyle = .rounded
        button.target = self
        button.action = #selector(startTimer)
        window.contentView?.addSubview(button)
    }

    @objc func startTimer(sender: NSButton) {
        // Get number of minutes from slider
        let minutes = sender.window?.contentView?.subviews.first(where: { $0 is NSSlider }) as? NSSlider
        let selectedMinutes = minutes?.intValue ?? 10

        // Start timer
        print("Timer started for \(selectedMinutes) minute(s)...")
        for i in (0..<(selectedMinutes * 60)).reversed() {
            Thread.sleep(forTimeInterval: 1)
            // Calculate time remaining and update display on same line
            let remaining = i - 1
            print("\(i) second(s) remaining...", terminator: "\r")
            fflush(__stdoutp)
        }

        // Pause VLC
        let script = """
            tell application "VLC" to pause
            """
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            scriptObject.executeAndReturnError(&error)
        }

        // Display message and countdown
        print("\nMusic paused, computer going to sleep...")
        for i in (0...10).reversed() {
            // Update display on same line
            print("\(i)...", terminator: "\r")
            fflush(__stdoutp)
            Thread.sleep(forTimeInterval: 1)
        }

        // Put computer to sleep
        let sleepScript = """
            tell application "System Events" to sleep
            """
        if let scriptObject = NSAppleScript(source: sleepScript) {
            scriptObject.executeAndReturnError(&error)
        }

        // Close the window
        window.close()
    }
}
