//
//  NewResource.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 21/08/2022.
//

import Foundation
import UIKit

protocol NewsProtocol{
    func getNewsData(completion: @escaping(Result<GetNewsData, UserError>) -> Void)
}

struct NewsResource: NewsProtocol {
    private var httpUtility: UtilityService
    private var urlString: String = "\(API.baseUrl)\(API.path)\(API.param)\(API.apiKey)"
    
    static let cache = NSCache<NSString, UIImage>()
    
    init(httpUtility: UtilityService = HTTPUtility()){
        self.httpUtility = httpUtility
    }
    
    func getNewsData(completion: @escaping(Result<GetNewsData, UserError>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(.InvalidURL))
            return
        }
        httpUtility.performDataTask(url: url, resultType: GetNewsData.self) { result in
            switch result {
            case .success(let jsonData):
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
