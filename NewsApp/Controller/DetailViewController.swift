//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Aayushi Bhagat on 12/10/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var webview: WKWebView!
  
  // MARK: - Properties
  
  let viewModel = DetailViewModel()
  var activityIndicator: UIActivityIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
  }
  
  private func initialSetup() {
    setupWebView()
    configureIndicatorView()
  }
  
  private func setupWebView() {
    webview.navigationDelegate = self
    webview.allowsBackForwardNavigationGestures = true
    
    if let url = URL(string: viewModel.url) {
      let request = URLRequest(url: url)
      DispatchQueue.main.async {
        self.webview.load(request)
      }
    }
  }
  
  private func configureIndicatorView() {
    activityIndicator = UIActivityIndicatorView()
    activityIndicator.center = self.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = UIActivityIndicatorView.Style.medium
    activityIndicator.startAnimating()
    view.addSubview(activityIndicator)
  }
}

// MARK: - WKNavigationDelegate

extension DetailViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    decisionHandler(.allow)
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    activityIndicator.stopAnimating()
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    activityIndicator.stopAnimating()
  }
}
