//
//  ContentView.swift
//  TodayNews
//
//  Created by Norris Wise Jr on 10/15/24.
//

import SwiftUI

struct NewsFeedView: View {
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Latest")
					.font(.title2)
					.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
					.bold()
				Spacer()
				Text("See all")
					.font(.title2)
					.foregroundStyle(.gray)
					.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
			}
			ScrollView(.horizontal) {
				HStack(alignment: .center, spacing: 10) {
					ForEach(0..<1) { num in
						Text("All")
						Text("Sports")
					}
					.font(.title3)
					.foregroundStyle(Color.gray)
				}
			}
			.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
			
			
			List {
				HStack {
					Image("sampleNewsImage", bundle: .main)
					VStack(alignment: .leading) {
						Text("Europe")
							.font(.custom("Poppins", size: 18))
						
						Text("sdnksdjf vksjdnfv ksjdfn vlksjdfn vlsdjfkn vskdjfn sldkfjvn sldkfjvn dkfjvn dfkjvn d")
							.lineLimit(2)
							.padding(.trailing)
						HStack {
							Image("bbcNewsImage")
								.resizable()
								.frame(width: 20, height: 20)
							Text("CNN")
								.bold()
							Image("clockImage")
								.resizable()
								.frame(width: 14, height: 14)
							Text("14min ago")
								.foregroundStyle(.gray)
						}
						
						
					}
				}
			}
		}
		
	}
}

#Preview {
	NewsFeedView()
}
