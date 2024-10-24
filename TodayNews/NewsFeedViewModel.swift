//
//  ViewModel.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/15/24.
//

import Foundation
import SwiftUI

class NewsFeedViewModel: ObservableObject {
	@Published var pageTitle = "Latest"
	@Published var seeMoreBtnTitle = "See all"
	@Published var categories: [String] = []
	@Published var articles: [Article] = []
	var hasError: Binding<Bool> = .constant(false)
	@Published var errMsg = ""
	
	
	func getLatestArticles() async {
		Task {
			do {
				let (data, resp) = try await URLSession.shared.data(from: NewsAPI.latest.url)
				guard let urlResp = resp as? HTTPURLResponse,
					  (200..<300).contains(urlResp.statusCode) else {
					let errMsg = NewsAPIError.serverError("Could not get response").description
					print(errMsg)
					self.errMsg = errMsg
					DispatchQueue.main.async {
						self.hasError = .constant(true)
					}
					
					return
				}
				if let articles = try? JSONDecoder().decode(Articles.self, from: data) {
					DispatchQueue.main.async {
						self.articles = articles.articlesAry.filter { $0.urlToImage != nil }
					}
				} else {
					let errMsg = NewsAPIError.clientError("Could not parse data").description
					DispatchQueue.main.async {
						self.errMsg = errMsg
						self.hasError = .constant(true)
					}
					
				}
			} catch let err {
				let errMsg = NewsAPIError.clientError(err.localizedDescription).description
					print(err)
					DispatchQueue.main.async {
						self.errMsg = errMsg
						self.hasError = .constant(true)
					}
				
			}
		}
	}
	
}



class ArticleUtilities {
	static let shared = ArticleUtilities()
	private init() {}
}

extension ArticleUtilities {
	func getMidLongAuthor(_ author: String?) -> String {
		if let author {
			let this = "\(author.prefix(12))".replacingOccurrences(of: #"[-!@$#%^&*()_+=]"#, with: "", options: .regularExpression)
			return this
		} else {
			return "Unlisted"
		}
	}
	func getShortAuthor(_ author: String?) -> String {
		if let author {
			let this = "\(author.prefix(6))".replacingOccurrences(of: #"[-!@$#%^&*()_+=]"#, with: "", options: .regularExpression)
			return this
		} else {
			return "Unlisted"
		}
	}
	
	func generateLoremText(wordCount: Int) -> String {
		(0...wordCount).map { _ in
			Int.random(in: 1...5) > 2  ? "lorem" : "ipsum"
		}.joined(separator: " ")
	}
}
