//
//  ViewController.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 20/08/2022.
//

import UIKit
import SnapKit
import SafariServices

class HomeNewsViewController: UIViewController, NewsDelegate {
    
    let homeView  = HomeView()
    let viewModel  = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Feed"
        view.backgroundColor  = .tertiarySystemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setContraint()
        viewModel.delegate = self
        viewModel.receiveData()
        presentWebView()
    }
    


    func presentWebView() {
        homeView.loadWebView = { [weak self] url in
            let safariVc = SFSafariViewController(url: url)
            self?.navigationController?.present(safariVc, animated: true, completion: nil)
        }
    }
    
    func setContraint() {
        self.view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(50)
        }
    }

    func receiveData(_ data: GetNewsData) {
        homeView.injectData(data.articles)
    }
    
}

