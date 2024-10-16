//
//  WebView.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/16/24.
//

import Foundation
import SwiftUI
import WebKit


class WebViewController: UIViewController {
	let heightConstraint: NSLayoutConstraint = .init()
	
	let scrollView = UIScrollView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
	let webView = WKWebView()
	var obs: NSKeyValueObservation?
	
	func addConstraints() {
		
		self.webView.translatesAutoresizingMaskIntoConstraints = false
//		self.scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		
		//webView to ScrollView
		self.webView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
		self.webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
		
		
//		self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
//		self.scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
		
		
		
		self.webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		
		//scrollView to view
//		self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//		self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//		self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//		self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
	}
	func addSubviews() {
//		self.scrollView.addSubview(webView)
//		self.scrollView.backgroundColor = .blue
		self.webView.backgroundColor = .red
		self.view.addSubview(webView)
		
	}
	
//	func setupScrollView() {
//		scrollView.delegate = self
//		self.obs = scrollView.observe(\.contentSize) { scrollView, change in
//			print("didChange: \(change)")
//			self.webView.heightAnchor.constraint(equalToConstant: <#T##CGFloat#>)
//		}
//	}
	func setupWebView() {
		webView.uiDelegate = self
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
	func load(_ url: URL) {
		let request = URLRequest(url: url)
		self.webView.load(request)
	}
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		print("Content Size: \(webView.scrollView.contentSize)")
		self.webView.heightAnchor.constraint(equalToConstant: webView.scrollView.contentSize.height).isActive = true
		
	}
}


struct WebView2: UIViewControllerRepresentable {
	typealias UIViewControllerType = UIViewController
	let urlString: String?
	
	func makeUIViewController(context: Context) -> UIViewController {
		let webVC = WebViewController()
		return webVC
	}
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		guard let webVC = uiViewController as? WebViewController, let urlString, let url = URL(string: urlString) else {
			print("Error: Could not load WebViewController")
			return
		}
		webVC.load(url)
	}
	func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: UIViewController, context: Context) -> CGSize? {
		print("-----------------------------------------")
		print(proposal, uiViewController, context)
		print("-----------------------------------------")
		return CGSize(width: proposal.width!, height: proposal.height!)
	}
}
struct WebView: UIViewRepresentable {
	let urlString: String?
	
	func makeUIView(context: Context) -> some UIView {
		let webView = WKWebView()
		return webView
	}
	func updateUIView(_ uiView: UIViewType, context: Context) {
		guard let webView = uiView as? WKWebView,
			  let urlString,
			  let url = URL(string: urlString) else {
			print("Error: could not load webView")
			return
		}
		let request = URLRequest(url: url)
		webView.load(request)
	}
}


extension WebViewController: UIScrollViewDelegate {

	
}
