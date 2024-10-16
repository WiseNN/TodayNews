//
//  NewsReaderView.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/16/24.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct NewsReaderView: View {
	var viewModel: NewsReaderViewModel
	
	var body: some View {
		VStack(alignment: .center) {
			HStack(alignment: .center) {
//				CachedAsyncImage(url: URL(string: article.urlToImage ?? "")) { img in
//					let image = img.image ?? Image("bbcNewsImage")
//					return image
//						.resizable()
//						.frame(width: 100, height: 100)
//				}
				Image("bbcNewsImageLarge")
					.resizable()
					.frame(width: 50, height: 50)
					.aspectRatio(contentMode: .fill)
				VStack(alignment: .leading) {
					Text("BBC News")
						.foregroundStyle(.black)
						.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
					Text("14m ago")
						.font(.subheadline)
						.foregroundStyle(Color.gray)
				}
				Spacer()
				Button(action: {
					print("Tapped follow btn...")
				}, label: {
					Text("Following")
						.padding(EdgeInsets(top: 9, leading: 15, bottom: 9, trailing: 15))
						.font(.subheadline)
						.fontWeight(.bold)
						.background(Color.followBtn)
						.foregroundStyle(.white)
						.clipShape(RoundedRectangle(cornerRadius: 6))
						
						
				})
			}
			.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
			Image("newsStoryImage")
				.aspectRatio(2/1, contentMode: .fill)
			HStack {
				Text(viewModel.getShortAuthor(viewModel.article.author))
					.font(.custom("Poppins", size: 18))
					.foregroundStyle(.gray)
				Spacer()
			}
			.padding([.leading, .trailing])
			
				WebView2(urlString: viewModel.article.url)
			
		}
	}
}
let nrViewModel = NewsReaderViewModel(article: Article(source: Source()))


#Preview {
	NewsReaderView(viewModel: NewsReaderViewModel(article: Article(id: UUID(), source: Source(id: "cnn", name: "cnn"), author: "Stacey", title: "COVID-Recovery", description: nrViewModel.generateLoremText(wordCount: 20), url: "https://www.cnn.com/2024/10/14/sport/nfl-week-6-sunday-review-spt-intl/index.html", urlToImage: nil, publishedAt: nil, content: nrViewModel.generateLoremText(wordCount: 200))))
}
