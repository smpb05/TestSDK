        let fff = WebViewProvider()
        fff.setWebView(webView: webView)
        Tets().callback = { data in
            print("Received data: \(data)")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            fff.loadPage()
        }
