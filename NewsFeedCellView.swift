//
//  NewsFeedCellView.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/17/24.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct NewsFeedCellView: View {
	let article: Article
	
	var body: some View {
		HStack {
			
			CachedAsyncImage(url: URL(string: article.urlToImage ?? ""), urlCache: .imageCache) { img in
				let image = img.image ?? Image("bbcNewsImage")

				image
					.resizable()
					.frame(width: 90, height: 90)
					.clipShape(RoundedRectangle(cornerRadius: 10))
			}
			
			
			VStack(alignment: .leading) {
				Text(ArticleUtilities.shared.getShortAuthor(article.author))
					.font(.custom("Poppins", size: 18))
					.foregroundStyle(.gray)
					
				
				Text(article.title ?? "[missing article]")
					.lineLimit(2, reservesSpace: true)
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
			Spacer()
		}
		.frame(maxWidth: .infinity)
	}
}



#Preview {
	NewsFeedCellView(article: Article(source: Source()))
}
