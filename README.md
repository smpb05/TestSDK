// Example

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let messageHandler = MessageHandler()
        messageHandler.onCallFinish = {
            print("Received data: call has finished")
        }
        
        var provider = WebViewProvider()
        provider.setWebView(webView: webView, messageHandler: messageHandler, isVideoCall: false)
        
        let pageLoaded = provider.loadPage()
        print(pageLoaded)
