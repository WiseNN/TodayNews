//
//  ContentView.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/15/24.
//

import SwiftUI
import CachedAsyncImage

enum NewsAPIError: Error {
	case clientError(String), serverError(String)
	var description: String {
		switch self {
			case .clientError(let msg): return "Error: \(msg)"
			case .serverError(let msg): return "Error: \(msg)"
		}
	}
}
enum NewsAPI {
	case latest
	
	var url: URL {
		switch self {
			case .latest: return URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=f79971a0373d405c8de63ed005117b88")!
		}
	}
}



struct NewsFeedView: View {
	@ObservedObject var viewModel: NewsFeedViewModel
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text(viewModel.pageTitle)
					.font(.title2)
					.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
					.bold()
				Spacer()
				Text(viewModel.seeMoreBtnTitle)
					.font(.title2)
					.foregroundStyle(.gray)
					.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
			}
			ScrollView(.horizontal) {
				
				HStack(alignment: .center, spacing: 10) {
					ForEach(viewModel.categories, id: \.self) { categoryName in
						Text(categoryName)
					}
					.font(.title3)
					.foregroundStyle(Color.gray)
				}
			}
			.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
			NavigationView {
				List(viewModel.articles) { article in
						NavigationLink {
							if let _ = article.url {
								NewsReaderView(viewModel: NewsReaderViewModel(article: article))
							} else {
								Text("Sorry, this article is not present")
							}
						} label: {
							NewsFeedCellView(article: article)
						}
					.frame(height: 112)
				}
			}
			.refreshable {
				Task {
					await viewModel.getLatestArticles()
				}
			}
		}
		.task {
			await viewModel.getLatestArticles()
			
		}
		.alert(isPresented: viewModel.hasError, content: {
			Alert(title: Text("Error"), message: Text("Cannot Retreive News Articles"), dismissButton: .destructive(Text("Ok")))
		})
		
	}
		
}

#Preview {
	NewsFeedView(viewModel: NewsFeedViewModel())
}


extension URLCache {
	
	static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
