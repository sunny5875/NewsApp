//
//  ContentView.swift
//  NewsPractice
//
//  Created by 현수빈 on 6/12/24.
//

import SwiftUI

struct NaverNewsView: View {
    
    @StateObject var viewModel: NaverNewsViewModel
    
    @State var isTap: Bool = false
    @State var url: String?
    
    var body: some View {
        NavigationView {
            List {
                if let date = viewModel.searchResult?.lastBuildDate {
                    Text("날짜: \(date)")
                        .font(.callout)
                        .foregroundStyle(Color.gray)
                }
                if let itemList = viewModel.searchResult?.items {
                    ForEach(itemList, id: \.title) { entity in
                        cell(entity)
                            .onTapGesture {
                                isTap.toggle()
                                url = entity.originallink
                            }
                    }
                }
            }
            .navigationTitle("News")
            .task {
                viewModel.requestAPIToNaver(queryValue: "애플")
            }
            .sheet(isPresented: $isTap) {
                if let url {
                    WKWebViewPractice(url: url)
                }
            }
        }
    }
    
    @ViewBuilder
    func cell(_ entity: NaverNewsItem) -> some View {
        HStack(spacing: 12) {
            Image(uiImage: UIImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding()
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entity.title)
                    .font(.headline)
                Text(entity.itemDescription)
                    .lineLimit(3)
                    .font(.body)
                    .foregroundStyle(Color.gray)

                Text(entity.pubDate)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}
