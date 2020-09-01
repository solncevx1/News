//
//  Articles.swift
//  TestProject
//
//  Created by Максим Солнцев on 6/11/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import Foundation


struct Article: Decodable {  
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var sourceName: String?
        
}

struct ArticlesResponse: Decodable {
    
    enum Status: String, Decodable {
        case ok
        case error
        
    }
    
    let status: Status
    let articles: [Article]
    let message: String?
    
}












