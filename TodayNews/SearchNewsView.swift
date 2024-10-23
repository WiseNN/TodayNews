//
//  SearchNewsView.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/17/24.
//

import Foundation
import SwiftUI




struct SearchNewsView: View {
	@State var searchText = ""
	@ObservedObject var viewModel = SearchNewsViewModel()
	
	var body: some View {
		NavigationStack {
			VStack(alignment: .center) {
				if viewModel.articles.isEmpty {
					Image(systemName: "newspaper")
						.resizable()
						.frame(width: 100, height: 100)
						.aspectRatio(1, contentMode: .fit)
						.padding(EdgeInsets(top: 150, leading: 0, bottom: 0, trailing: 0))
					Text("Search Latest News Articles of Today")
						.padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
						Spacer()
				} else {
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
			}
			.frame(maxWidth: .infinity)
		}
		.searchable(text: $searchText)
		.onChange(of: searchText) { oldValue, newValue in
			viewModel.searchArticles(with: newValue)
		}
	}
}



#Preview {
	SearchNewsView()
}
