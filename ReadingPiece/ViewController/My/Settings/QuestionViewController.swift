//
//  QuestionViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/29.
//

import UIKit
import WebKit

class QuestionViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webview: WKWebView!
    
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
        let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSeKI2msAMe0hNXxNrCOWHlCBMhdAlMj4xJ4CwpDrVwP2zDB6Q/viewform?usp=sf_link")
        let request = URLRequest(url: url!)
        webview?.allowsBackForwardNavigationGestures = true
        webview.configuration.preferences.javaScriptEnabled = true
        webview.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
