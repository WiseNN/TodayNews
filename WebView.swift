//
//  WebView.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/16/24.
//

import Foundation
import SwiftUI
import WebKit




















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

	override func preferredContentSizeDidChange(forChildContentContainer container: any UIContentContainer) {
		print("did change content size")
	}
}
