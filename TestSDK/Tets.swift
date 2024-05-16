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
            if let callback = callback {
                print("Callback workds")
                callback(message.body as! String)
            } else
            {
                print("not working")
            }
        }
    }
    
}
