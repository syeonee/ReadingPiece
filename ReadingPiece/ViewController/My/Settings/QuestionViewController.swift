//
//  QuestionViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/29.
//

import UIKit
import WebKit
import KeychainSwift

class QuestionViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webview: WKWebView!
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    var questionUriInfo: UriInfo!
    
    override func loadView() {
        super.loadView()
        webview = WKWebView()
        webview.uiDelegate = self
        webview.navigationDelegate = self
        self.view = self.webview
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .darkgrey
        getQuestionURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getQuestionURL(){
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: PageURLRequest(token: token, uriId: 2)) { [self] result in
            switch result {
            case .success(let response):
                self.dismissIndicator()
                let result = response.code
                if result == 1000 {
                    DispatchQueue.main.async {
                        questionUriInfo = response.uriInfo[0]
                        let url = URL(string: questionUriInfo.uri)
                        let request = URLRequest(url: url!)
                        webview?.allowsBackForwardNavigationGestures = true
                        webview.configuration.preferences.javaScriptEnabled = true
                        webview.load(request)
                    }
                }
            case .cancel(let cancelError):
                self.dismissIndicator()
                print(cancelError as Any)
            case .failure(let error):
                self.dismissIndicator()
                print(error as Any)
            }
        }
    }
    
    //alert 처리
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //confirm 처리
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
        self.present(alertController, animated: true, completion: nil) }
    
    // href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }
        return nil }

}
