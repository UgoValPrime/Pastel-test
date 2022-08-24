//
//  GetNewsModel.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 20/08/2022.
//

import Foundation
import UIKit

// MARK: - NewsData
struct GetNewsData: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title: String?
    let url: String?
    let urlToImage: String?
}


