// Example

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var messageHandler = MessageHandler()
        messageHandler.callback = { data in
            // call has ended
        }
        
        var wvProviderb = WebViewProvider()
        wvProviderb.setWebView(webView: webView, messageHandler: messageHandler)
        
        let pageLoaded = wvProviderb.loadPage()
        print(pageLoaded)


https://web-videobank.halykbank.kz/qa/client/#/personalcall?callHash=6D600C1912B755E9BDE45CBA5A965871
