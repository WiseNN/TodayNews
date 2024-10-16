//
//  TabViewContainer.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/16/24.
//

import Foundation
import SwiftUI



struct TabViewContainer: View {
	var body: some View {
		TabView {
			NewsFeedView()
				.tabItem {
					Text("News Feed")
				}
		}
	}
}


#Preview {
	TabViewContainer()
}
