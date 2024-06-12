//
//  NewsAPIView.swift
//  NewsPractice
//
//  Created by 현수빈 on 6/12/24.
//

import SwiftUI

struct NewsAPIView: View {
    
    @StateObject var viewModel: NewsAPIViewModel
    
    @State var isTap: Bool = false
    @State var url: String?
    
    var body: some View {
        NavigationView {
            List {
                if let date = viewModel.searchResult?.totalResults {
                    Text("총 개수: \(date)")
                        .font(.callout)
                        .foregroundStyle(Color.gray)
                }
                if let itemList = viewModel.searchResult?.articles {
                    ForEach(itemList, id: \.title) { entity in
                        cell(entity)
                            .onTapGesture {
                                isTap.toggle()
                                url = entity.url
                            }
                    }
                }
            }
            .navigationTitle("News")
            .task {
                viewModel.requestAPI(queryValue: "애플")
            }
            .sheet(isPresented: $isTap) {
                if let url {
                    WKWebViewPractice(url: url)
                }
            }
        }
    }
    
    @ViewBuilder
    func cell(_ entity: Article) -> some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: entity.urlToImage ?? "")) { image in
                    image.resizable()
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                } placeholder: {
                    ProgressView()
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entity.title)
                    .font(.headline)
                Text(entity.description)
                    .lineLimit(3)
                    .font(.body)
                    .foregroundStyle(Color.gray)
                
                Text(entity.source.name)
                    .font(.caption)
                    .foregroundStyle(Color.gray)

                Text(entity.publishedAt)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}
