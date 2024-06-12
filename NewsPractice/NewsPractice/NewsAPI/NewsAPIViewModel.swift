//
//  NewsAPIViewModel.swift
//  NewsPractice
//
//  Created by 현수빈 on 6/12/24.
//

import Foundation
import UIKit

final class NewsAPIViewModel: ObservableObject {
    
    @Published var searchResult : NewAPIModel?
    let jsconDecoder: JSONDecoder = JSONDecoder()

    
    func requestAPI(queryValue: String) {
        
        let clientKEY: String = "CLIENT KEY"
        
        let query: String  = "https://newsapi.org/v2/everything?q=\(queryValue)&apiKey=\(clientKEY)"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
       
        var requestURL = URLRequest(url: queryURL)
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil,
                  let data = data
            else { return }
            
            do {
                let searchInfo = try self.jsconDecoder.decode(NewAPIModel.self, from: data)
                self.searchResult = searchInfo
                print(self.searchResult)
            } catch {
            }
        }
        task.resume()
    }
}
