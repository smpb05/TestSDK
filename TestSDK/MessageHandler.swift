
import Foundation
import WebKit

public class MessageHandler: NSObject, WKScriptMessageHandler {
    
    public var onCallFinish: (() -> Void)?
    
    public func userContentController(_ userContent: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == "jsHandler",
        let body = message.body as? String else {
            print("MessageHandler: Invalid message received")
            return
        }
        
        print("MessageHandler got message: \(body)")
        
        switch body {
        case "getDeviceData":
            WebViewProvider.provider.setDeviceData()
            
        case "onCallFinish":
            if let onCallFinish = onCallFinish {
                onCallFinish()
            } else {
                print("MessageHandler onCallFinish is not defined")
            }
            
        default:
            break;
        }
    }
}
