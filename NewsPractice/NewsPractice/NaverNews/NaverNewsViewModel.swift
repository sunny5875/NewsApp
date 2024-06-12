//
//  ViewModel.swift
//  NewsPractice
//
//  Created by 현수빈 on 6/12/24.
//
import Foundation
import UIKit

final class NaverNewsViewModel: ObservableObject {
    
    @Published var searchResult : Welcome?
    let jsconDecoder: JSONDecoder = JSONDecoder()

    
    func requestAPIToNaver(queryValue: String) {
        
        let clientID: String = "CLIENT ID"
        let clientKEY: String = "CLIENT KEY"
        
        let query: String  = "https://openapi.naver.com/v1/search/news.json?query=\(queryValue)"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
       
        var requestURL = URLRequest(url: queryURL)
        requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        requestURL.addValue(clientKEY, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil,
                  let data = data
            else {
                print(error?.localizedDescription)
                return
            }
            
            do {
                let searchInfo: Welcome = try self.jsconDecoder.decode(Welcome.self, from: data)
                
                self.searchResult = searchInfo
                print(self.searchResult)
            } catch {
                print(fatalError())
            }
        }
        task.resume()
    }
}
