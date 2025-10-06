import Cocoa
import FlutterMacOS
import desktop_multi_window

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    
    // Registrar desktop_multi_window
    FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
      // Registrar plugins para cada nueva ventana
      RegisterGeneratedPlugins(registry: controller)
    }

    super.awakeFromNib()
  }
}
