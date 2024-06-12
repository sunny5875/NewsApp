//
//  TabView.swift
//  NewsPractice
//
//  Created by 현수빈 on 6/12/24.
//

import SwiftUI

struct CustomTabView: View {
    var body: some View {
        TabView {
            NaverNewsView(viewModel: NaverNewsViewModel())
                .tabItem {
                    Image(systemName: "1.square")
                    Text("네이버뉴스")
                }
            NewsAPIView(viewModel: NewsAPIViewModel())
                .tabItem {
                    Image(systemName: "2.square")
                    Text("NewsAPI")
                }
        }
    }
}
