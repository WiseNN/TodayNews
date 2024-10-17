//
//  NewsReaderViewModel.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/16/24.
//

import Foundation
import SwiftUI

class NewsReaderViewModel: ObservableObject {
	var article: Article
	
	
	init(article: Article) {
		self.article = article
	}
}
