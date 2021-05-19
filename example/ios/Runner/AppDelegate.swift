import UIKit
import Flutter
import Fuzi

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var name: String = "com.ii6.xpath"
    var document: XMLDocument?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller :FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let channel = FlutterMethodChannel(name: name, binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "parse":
                self.parse(call: call, result: result)
            case "parseString":
                self.parseString(call: call, result: result)
            case "parseList":
                self.parseList(call: call, result: result)
            case "parseListTitleAndHref":
                self.parseListTitleAndHref(call: call, result: result)
            default:
                result(FlutterMethodNotImplemented)
                return
            }
        })
        
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func parse(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let html: String? = (call.arguments as? [String: Any])?["html"] as? String
        self.document = try! HTMLDocument(string: html!)
        
        guard self.document != nil else {
            result(nil)
            return
        }
        
        result(true)
    }
    
    private func parseString(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let rule: String? = (call.arguments as? [String: Any])?["rule"] as? String
        let node = self.document?.firstChild(xpath: rule!)?.stringValue
        
        guard !node!.isEmpty else {
            result(nil)
            return
        }
        
        result(node)
    }
    
    private func parseList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let rule: String? = (call.arguments as? [String: Any])?["rule"] as? String
        let node = self.document!.xpath(rule!)
        var list = [String]()
        
        guard !node.isEmpty else {
            result(nil)
            return
        }
        
        for item in node {
            list.append(item.stringValue)
        }
        
        result(list)
    }
    
    private func parseListTitleAndHref(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let rule: String? = (call.arguments as? [String: Any])?["rule"] as? String
        let node = self.document!.xpath(rule!)
        var list = [[String]]()
        
        guard !node.isEmpty else {
            result(nil)
            return
        }
        
        for item in node {
            list.append([item.stringValue, item["href"]!])
        }
        
        result(list)
    }
}


