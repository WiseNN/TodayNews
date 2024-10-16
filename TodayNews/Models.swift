//
//  Models.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/16/24.
//

import Foundation



struct Articles: Codable {
	
	var status: String?
	var totalResults: Int?
	var articlesAry: [Article]
	enum CodingKeys: String, CodingKey {
		case status
		case totalResults
		case articlesAry = "articles"
	}
}
struct Article: Codable, Identifiable {
	var id = UUID()
	var source: Source
	var author: String?
	var title: String?
	var description: String?
	var url: String?
	var urlToImage: String?
	var publishedAt: String?
	var content: String?
	
	
	enum CodingKeys: String, CodingKey {
		case source,
		author,
		title,
		description,
		url,
		urlToImage,
		publishedAt,
		content
	}
}

struct Source: Codable {
	var id: String?
	var name: String?
}
