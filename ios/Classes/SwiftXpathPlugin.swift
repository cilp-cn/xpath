import Flutter
import UIKit
import Fuzi

public class SwiftXpathPlugin: NSObject, FlutterPlugin {
    
    var document: XMLDocument?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.ii6.xpath", binaryMessenger: registrar.messenger())
        let instance = SwiftXpathPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
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
        }
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


