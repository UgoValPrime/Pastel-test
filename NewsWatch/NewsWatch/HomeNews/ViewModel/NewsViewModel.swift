//
//  NewsViewModel.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 20/08/2022.
//

import Foundation

protocol NewsDelegate: AnyObject{
    func receiveData(_ data: GetNewsData)
}
class NewsViewModel {
    weak var delegate: NewsDelegate?
    public lazy var newsResource: NewsProtocol = NewsResource()
    
    func receiveData() {
        newsResource.getNewsData { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.delegate?.receiveData(listOf)
            case .failure(let error):
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }
}
