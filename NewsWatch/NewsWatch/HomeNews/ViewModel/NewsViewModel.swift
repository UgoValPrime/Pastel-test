//
//  NewsViewModel.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 20/08/2022.
//

import Foundation
import Network

protocol NewsDelegate: AnyObject{
    func receiveData(_ data: GetNewsData?)
}
class NewsViewModel {
    weak var delegate: NewsDelegate?
    let userDefaults  = UserDefaults.standard
    public lazy var newsResource: NewsProtocol = NewsResource()
    let monitor = NWPathMonitor()
    var noNetwork = false
    var homeView = HomeView()
    
    
     
    
    func monitorNetwork() {
        monitor.pathUpdateHandler = { [self] path in
            if path.status == .satisfied {
                self.receiveData()
                noNetwork = true
            } else {
                self.homeView.injectData(self.userDefaults.offlineNews?.articles ?? [])
            }
            print(path.isExpensive)
        }
    }
    
    func receiveData() {
        newsResource.getNewsData { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.delegate?.receiveData(listOf)
                self?.userDefaults.offlineNews  = listOf
            case .failure(let error):
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }
}
