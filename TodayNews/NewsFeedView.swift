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
	@ObservedObject var viewModel = ViewModel()
	
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
			
			
			List(viewModel.articles) { article in
				
				HStack {
					
					CachedAsyncImage(url: URL(string: article.urlToImage ?? ""), urlCache: .imageCache) { img in
						let image = img.image ?? Image("bbcNewsImage")

						return image
							.resizable()
							.frame(width: 100, height: 100)
					}
					
					
					VStack(alignment: .leading) {
						Text(article.title ?? "--")
							.font(.custom("Poppins", size: 18))
						
						Text(article.title ?? "[missing article]")
							.lineLimit(2)
							.padding(.trailing)
						HStack {
							Image("bbcNewsImage")
								.resizable()
								.frame(width: 20, height: 20)
							Text(article.source.name ?? "News")
								.bold()
							Image("clockImage")
								.resizable()
								.frame(width: 14, height: 14)
							Text(">24 hrs ago")
								.foregroundStyle(.gray)
						}
						
						
					}
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
	NewsFeedView()
}


extension URLCache {
	
	static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
