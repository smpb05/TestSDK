
import Foundation
import WebKit

public class MessageHandler: NSObject, WKScriptMessageHandler {
    
    public var callback: ((String) -> Void)?
    
    public func userContentController(_ userContent: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "jsHandler" {
            if let body = message.body as? String {
                callback?(body)
                print("MessageHandler got message: \(body)")
                
                if(body=="getDeviceData") {
                    WebViewProvider.provider.setDeviceData()
                }
            }
            else {
                print("MessageHandler: message body that I got from web page is not a String")
            }
        }
    }
}
