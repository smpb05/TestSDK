//
//  Tets.swift
//  TestSDK
//
//  Created by Anastasia Filinskaya on 16.05.2024.
//

import Foundation
import WebKit

public class Tets: NSObject, WKScriptMessageHandler {
    
    public var callback: ((String) -> Void)?
    
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
