//
//  ViewController.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 20/08/2022.
//

import UIKit
import SnapKit
import SafariServices

final class HomeNewsViewController: UIViewController, NewsDelegate {
    
    let homeView  = HomeView()
    var viewModel: NewsViewModel?
    let userDefaults = UserDefaults.standard
    let queue = DispatchQueue(label: Controller.monitor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setContraints()
        setup()
        presentWebView()
    }
    
    func didReceiveData(_ data: GetNewsData?) {
        homeView.configure(with: data?.articles ?? [])
    }
    
    fileprivate func presentWebView() {
        homeView.loadWebView = { [weak self] url in
            let safariVc = SFSafariViewController(url: url)
            self?.navigationController?.present(safariVc, animated: true, completion: nil)
        }
    }
    
    fileprivate func setContraints() {
        self.view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(50)
        }
    }
    
    fileprivate func configureViewController() {
        title = Controller.title
        view.backgroundColor  = .tertiarySystemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setup() {
        viewModel?.delegate = self
        viewModel?.monitorNetwork()
        viewModel?.monitor.start(queue: queue)
    }
    
}

