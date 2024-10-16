//
//  TodayNewsApp.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/15/24.
//

import SwiftUI



@main
struct TodayNewsApp: App {
	let nrViewModel = NewsReaderViewModel(article: Article(source: Source()))
    var body: some Scene {
        WindowGroup {
			NewsReaderView(viewModel: NewsReaderViewModel(article: Article(id: UUID(), source: Source(id: "cnn", name: "cnn"), author: "Stacey", title: "COVID-Recovery", description: nrViewModel.generateLoremText(wordCount: 20), url: "https://www.google.com", urlToImage: nil, publishedAt: nil, content: nrViewModel.generateLoremText(wordCount: 200))))

        }
    }
}







