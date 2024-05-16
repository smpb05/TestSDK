import Foundation
import WebKit

public class MessageHandler: NSObject, WKScriptMessageHandler {
    
    var callback: ((String) -> Void)?
    
    public func userContentController(_ userContent: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "jsHandler" {
            if let body = message.body as? String {
                callback?(body)
            }
            else {
                print("MessageHandler: message body that I got from web page is not a String")
            }
        }
    }
}
