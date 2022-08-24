//
//  UserDefaults+Extension.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 24/08/2022.
//

import Foundation

extension UserDefaults {
    enum UserDefaultKeys: String {
        case newsData
    }
    
    var offlineNews: GetNewsData? {
        get{
            get(key: UserDefaultKeys.newsData.rawValue, type: GetNewsData.self)
        }
        set {
            set(key: UserDefaultKeys.newsData.rawValue, newValue: newValue, type: GetNewsData.self)
        }
    }
    
    
    private func get<T: Codable>(key: String, type: T.Type) -> T? {
           if let savedData = object(forKey: key) as? Data {
               do {
                   return try JSONDecoder().decode(T.self, from: savedData)
               } catch {
                   print(error)
                   return nil
               }
           }
           return nil
       }
       private func set<T: Codable>(key: String, newValue: T?, type: T.Type) {
           if newValue == nil {
               removeObject(forKey: key)
               return
           }
           do {
               let encoded: Data = try JSONEncoder().encode(newValue)
               set(encoded, forKey: key)
           } catch {
               print(error)
           }
       }
    
}
