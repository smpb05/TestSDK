import UIKit
import WebKit
import AVFoundation

class WebViewProvider: UIViewController{

    private var webView: WKWebView!
    private var permissionsAllowed: Bool = false
    private let url: URL = URL(string: "https://mvc.t2m.kz/demos/echotest.html")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestPermissions()
    }
    
    protocol WebViewProvider {
        func provideWebView() -> WKWebView
    }

    func getWebView() -> WKWebView {
        let preference = WKWebpagePreferences()
        preference.preferredContentMode = .mobile
        preference.allowsContentJavaScript = true
        
        let conf = WKWebViewConfiguration()
        conf.defaultWebpagePreferences = preference
        webView.load(URLRequest(url: url))
        
        return webView
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
        
        if videoAuthorized && audioAuthorized {
            permissionsAllowed = true
            openWebView()
        }
    }
}

    
