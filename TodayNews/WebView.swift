//
//  WebKit2.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/16/24.
//

import Foundation
import SwiftUI
struct WebView: UIViewControllerRepresentable {
	typealias UIViewControllerType = UIViewController
	let urlString: String?
	@Binding var didLoadContent: Bool
	@Binding var webHeight: CGFloat
	
	func makeUIViewController(context: Context) -> UIViewController {
		let webVC = WebViewController()
		return webVC
	}
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		guard let webVC = uiViewController as? WebViewController, let urlString, let url = URL(string: urlString) else {
			print("Error: Could not load WebViewController")
			return
		}
		guard !self.didLoadContent else {
			print("Already loaded content")
			return
		}
		webVC.load(url) { didLoad, size, vc in
			if didLoad {
				self.didLoadContent = didLoad
//				self.webHeight = size.height
			} else {
				print("Error: could not load webpage.")
			}
		}
	}
	func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: UIViewController, context: Context) -> CGSize? {
		if 	let webVC = uiViewController as? WebViewController,
			let width = proposal.width, !(width == .zero) {
			return CGSize(width: width, height: webVC.heightConstraint.constant)
		} else {
			return nil
		}
				
	}
}
