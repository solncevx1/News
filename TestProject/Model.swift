//
//  Model.swift
//  TestProject
//
//  Created by Максим Солнцев on 6/11/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//
import Foundation


class NewsDataSource {
    
    var articles: [Article] = []
    
    func loadNews(complitionHandler: @escaping ([Article]) -> ()) {
        let urlString = "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a47e4642e8e54fe09f510182450c27b5"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                let articleList = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                if articleList.status == .ok {
                    self.articles = articleList.articles
                } else { return }
                
                complitionHandler(self.articles)
            } catch {
                print(error)
            }
        }
        .resume()
    }
}


