import UIKit
import WebKit
import AVFoundation

public class WebViewProvider {

    private var webView: WKWebView!
    private var permissionsAllowed: Bool = false
    private let url: URL = URL(string: "https://mvc.t2m.kz/demos/event-test.html")!
    
    public init() {}

    public func loadPage() -> Bool {
        checkPermissions()
        
        if !permissionsAllowed {
            print("WebViewProvider error: permissions are not allowed")
            return false
        }
        
        clearCache()
        
        let conf = WKWebViewConfiguration()
            
        if #available(iOS 14.0, *) {
//            WKWebpagePreferences().preferredContentMode = .mobile
//            WKWebpagePreferences().allowsContentJavaScript = true
//            WKWebViewConfiguration().websiteDataStore = WKWebsiteDataStore.nonPersistent()
//            WKWebViewConfiguration().preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
            
            let preference = WKWebpagePreferences()
            preference.preferredContentMode = .mobile
            preference.allowsContentJavaScript = true
            conf.defaultWebpagePreferences = preference
            conf.websiteDataStore = WKWebsiteDataStore.nonPersistent()
            conf.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
            
            
            webView.configuration.userContentController.add(MessageHandler(), name: "jsHandler")
            
            var request = URLRequest(url: url)
            request.cachePolicy = .reloadIgnoringLocalCacheData
            
            webView.load(request)
            
            print("WebViewProvider: webView has loaded")
            return true
        }
        else {
            webView.load(URLRequest(url: url))
            
            print("WebViewProvider: webView has loaded, but ios version is too low")
            return true
        }
    }
    
    private func clearCache() {
            URLCache.shared.removeAllCachedResponses()
            URLCache.shared.diskCapacity = 0
            URLCache.shared.memoryCapacity = 0
    }
    
    public func setWebView(webView: WKWebView) {
        self.webView = webView
        requestPermissions()
    }
    
    public func setUser(phone: String) {
        let js = "setUserData('\(phone)');"
        webView.evaluateJavaScript(js) { (result, error) in
            if let error = error {
                print("WebViewProvider-setUser: \(error)")
            } else {
                print("WebViewProvider-setUser: Data have set successfully")
            }
        }
    }
    
    private func requestPermissions() {
        AVCaptureDevice.requestAccess(for: .video) {[weak self] granted in
            guard let self = self else {return}
            if(granted) {
                DispatchQueue.main.async {
                    self.checkPermissions()
                }
            }
        }
        
        AVCaptureDevice.requestAccess(for: .audio) {[weak self] granted in
            guard let self = self else {return}
            if(granted) {
                DispatchQueue.main.async {
                    self.checkPermissions()
                }
            }
        }
    }
    
    private func checkPermissions() {
        let videoAuthorized = AVCaptureDevice.authorizationStatus(for: .video) == .authorized
        let audioAuthorized = AVCaptureDevice.authorizationStatus(for: .audio) == .authorized
        
        print("WebViewProvider: camera access granted - " + String(videoAuthorized))
        print("WebViewProvider: microphone access granted - " + String(audioAuthorized))
        
        if videoAuthorized && audioAuthorized {
            permissionsAllowed = true
        }
    }
}

    
