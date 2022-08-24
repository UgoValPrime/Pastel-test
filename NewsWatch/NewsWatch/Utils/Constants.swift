//
//  Constants.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 21/08/2022.
//

import Foundation

struct API {
    static let baseUrl = "https://newsapi.org/v2"
    static let path = "/top-headlines?"
    static let param = "country=us&apiKey="
    static let apiKey = "2d021085c2e64c23927ff485d9f4299b"
}


struct Controller  {
    static let monitor = "Monitor"
    static let title = "News Feed"
}

struct View {
    static let headerColor = "header"
    static let headerText = "Top news"
}
