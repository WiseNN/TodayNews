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
	var obs: NSKeyValueObservation?
	
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
		
		//scrollView to view
//		self.scrollView.translatesAutoresizingMaskIntoConstraints = false
//		let scrollTop = NSLayoutConstraint(item: self.scrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
//
//		let scrollTrail = NSLayoutConstraint(item: self.scrollView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
//
//		let scrollBottom = NSLayoutConstraint(item: self.scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
//
//		let scrollLead = NSLayoutConstraint(item: self.scrollView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
//		let scrollH = NSLayoutConstraint(item: self.scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
//
//		let scrollW = NSLayoutConstraint(item: self.scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: <#T##NSLayoutConstraint.Attribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
//		self.view.addConstraints([scrollTop, scrollTrail, scrollBottom, scrollLead])
	}
	func addSubviews() {
//		self.scrollView.addSubview(webView)
//		self.scrollView.backgroundColor = .blue
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
		
//		self.obs = webView.scrollView.observe(\.contentSize) { scrollView, change in
//			self.scrollView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height).isActive = true
//		}
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
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.obs?.invalidate()
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

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		print("Content Size: \(webView.scrollView.contentSize)")

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			
			self.heightConstraint.constant = webView.scrollView.contentSize.height
//			self.view.layoutIfNeeded()
			self.callback?(true,self.scrollView.contentSize, self)
//			self.scrollView.contentSize = webView.scrollView.contentSize
//			self.scrollView.layoutIfNeeded()
			
		}
		
	}
}


