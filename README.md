    public func setUser(phone: String) {
        let js = "setUserData('\(phone)');"
//        let js = "window.setUserData({phone: \"+7777777\"});"
        webView.evaluateJavaScript(js) { (result, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Data sent successfully")
            }
        }
    }
