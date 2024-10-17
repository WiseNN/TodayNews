//
//  WebViewController.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/16/24.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
	var heightConstraint: NSLayoutConstraint!
	var callback: ((Bool, CGSize, UIViewController) -> Void)? = nil
	
	let scrollView = UIScrollView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
	let webView = WKWebView()
	
	func addConstraints() {
		
		heightConstraint = NSLayoutConstraint(item: self.webView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100)
		//webView
		self.webView.addConstraint(heightConstraint)
		
		//webView to scrollView
		self.webView.translatesAutoresizingMaskIntoConstraints = false
		let webW = NSLayoutConstraint(item: self.webView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
		let topWeb = NSLayoutConstraint(item: self.webView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
		let trailWeb = NSLayoutConstraint(item: self.webView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
		let bottomWeb = NSLayoutConstraint(item: self.webView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
		let leadWeb = NSLayoutConstraint(item: self.webView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
		self.view.addConstraints([topWeb, trailWeb, bottomWeb, leadWeb, webW])
	}
	func addSubviews() {
		self.webView.backgroundColor = .red
		self.view.addSubview(webView)
		
	}
	
	func setupWebView() {
		webView.navigationDelegate = self
		webView.backgroundColor = .clear
		webView.scrollView.isScrollEnabled = false
		self.view.backgroundColor = .clear
	}
	func setupScrollView() {
		self.scrollView.delegate = self
	}
	func setup() {
		addSubviews()
		addConstraints()
		setupWebView()
		setupScrollView()
		
	}
	
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
// MARK: - Lifecycle
extension WebViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
}

//MARK: - Behavior
extension WebViewController {
	func load(_ url: URL, callback: @escaping (Bool, CGSize, UIViewController) -> Void) {
		let request = URLRequest(url: url)
		self.callback = callback
		self.webView.load(request)
	}
}

//MARK: - WebView Delegates
extension WebViewController: WKUIDelegate, WKNavigationDelegate {
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		DispatchQueue.main.async {
			self.heightConstraint.constant = webView.scrollView.contentSize.height
			self.callback?(true,self.scrollView.contentSize, self)
		}
	}
}

//MARK: - ScrollView Delegates
extension WebViewController: UIScrollViewDelegate {}
