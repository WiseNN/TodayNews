//
//  SearchNewsViewModel.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/17/24.
//

import Foundation
import SwiftUI


class SearchNewsViewModel: ObservableObject {
	@Published var hasError = false
	var errMsg = ""
	@Published var articles: [Article] = []
	var searchArticlesTask: Task<Void, Never>?
	
	func searchArticles(with term: String) {
		self.searchArticlesTask?.cancel()
		let urlStr = "https://newsapi.org/v2/everything?q=\(term.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? term)&apiKey=f79971a0373d405c8de63ed005117b88"
		let url = URL(string: urlStr)!
		let urlRequest = URLRequest(url: url)
		self.searchArticlesTask = Task {
			do {
				//wait a few secs
				try await Task.sleep(for: .seconds(1))
				let (data, urlResp ) = try await URLSession.shared.data(for: urlRequest)
				guard let httpResp = urlResp as? HTTPURLResponse,
					  (200..<300).contains(httpResp.statusCode) else {
					if data.count > 0, let errMsg = try JSONDecoder().decode(ErrorMessage.self, from: data).message {
						DispatchQueue.main.async {
							self.errMsg = errMsg
							self.hasError = true
						}
					} else {
						DispatchQueue.main.async {
							self.errMsg = "Could not perform search"
							self.hasError = true
						}
					}
					return
				}
				let articles = try JSONDecoder().decode(Articles.self, from: data)
				DispatchQueue.main.async {
					self.articles = articles.articlesAry.filter { $0.urlToImage != nil }
				}
			} catch let err {
				print("Search Error: \(err)")
				DispatchQueue.main.async {
					self.errMsg = err.localizedDescription
					self.hasError = true
				}
				
			}
		}
		
	}
}

