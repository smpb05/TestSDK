import Foundation
import WebKit

public class MessageHandler: NSObject, WKScriptMessageHandler {
    
    public func userContentController(_ userContent: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print(message.body)
        
        if message.name == "jsHandler" {
            print("webrtcDisconnected")
        }
    }
}
