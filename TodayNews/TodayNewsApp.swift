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
			NewsFeedView()
        }
    }
}







