import WebKit
#if canImport(AppKit)
import AppKit

open class PaymentView: NSView, WKNavigationDelegate {

    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.initWebView()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initWebView()
    }

    public var delegate: WebDelegate? = nil
    private var webView: WKWebView!
    private var sOf: ((Bool) -> Void)? = nil
    private var isFrame = true

    private func initWebView() {
        webView = WKWebView(frame: bounds)
        webView.configuration.preferences.javaScriptEnabled = true
        webView.navigationDelegate = self
        webView.autoresizingMask = [.width, .height]
        self.addSubview(webView)
    }

    func loadPaymentPage(url: String, sucessOrFailure: @escaping (Bool) -> Void) {
        if (url.starts(with: Urls.getBaseUrl()) || url.starts(with: Urls.getCustomerUrl())) {
            loadUrl(urlStr: url)
            self.sOf = sucessOrFailure
            self.isFrame = !url.contains("pay.html")
        }
    }

    private func loadUrl(urlStr: String) {
        if let url = URL(string: urlStr) {
            self.webView.load(URLRequest(url: url))
        }
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        if let url = navigationAction.request.url?.absoluteString {
            if url.starts(with: Urls.successUrl()) {
                self.sOf?(true)
                webView.loadHTMLString("", baseURL: nil)
            } else if url.starts(with: Urls.failureUrl()) {
                self.sOf?(false)
                webView.loadHTMLString("", baseURL: nil)
            }
        }
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.delegate?.loadFinished()
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.delegate?.loadStarted()
    }
}

public protocol WebDelegate {
    func loadStarted()
    func loadFinished()
}
#endif
