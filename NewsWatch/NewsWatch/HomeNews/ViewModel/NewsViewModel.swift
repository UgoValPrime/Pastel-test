//
//  NewsViewModel.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 20/08/2022.
//

import Foundation
import Network

protocol NewsDelegate: AnyObject{
    func didReceiveData(_ data: GetNewsData?)
}

final class NewsViewModel {
    
    weak var delegate: NewsDelegate?
    let userDefaults  = UserDefaults.standard
    var newsResource: NewsProtocol?
    let monitor = NWPathMonitor()
    var noNetwork = false
    
    init(newsResource: NewsProtocol = NewsResource()) {
        self.newsResource = newsResource
    }
    
    func monitorNetwork() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                self.receiveData()
                self.noNetwork = true
            } else {
                self.delegate?.didReceiveData(self.userDefaults.offlineNews)
            }
            print(path.isExpensive)
        }
    }
    
    func receiveData() {
        newsResource?.getNewsData { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.delegate?.didReceiveData(listOf)
                self?.userDefaults.offlineNews  = listOf
            case .failure(let error):
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }
}
