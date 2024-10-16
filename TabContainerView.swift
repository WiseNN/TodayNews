//
//  TabViewContainer.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/16/24.
//

import Foundation
import SwiftUI



struct TabContainerView: View {
	var body: some View {
		TabView {
			NewsFeedView()
				.tabItem {
					Text("News Feed")
						.font(.title)
						.foregroundStyle(.black)
						.tint(.black)
				}
		}
	}
}


#Preview {
	TabContainerView()
}
