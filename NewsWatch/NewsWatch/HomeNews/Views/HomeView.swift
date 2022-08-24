//
//  HomeView.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 20/08/2022.
//


import UIKit
import SnapKit


class HomeView: UIView {
    
    let contentView = UIView()
    let headerLabel = UILabel()
    let newsTableView = UITableView()
    var news: [Article]?
    
    var loadWebView: ((URL)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        newsTableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.addSubview(contentView)
        contentView.backgroundColor  = .tertiarySystemGroupedBackground
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        contentView.addSubview(headerLabel)
        headerLabel.backgroundColor = UIColor(named: "header")
        headerLabel.text = "Top news"
        headerLabel.font = .systemFont(ofSize: 14, weight: .medium)
        headerLabel.textColor  = .label
        headerLabel.textAlignment = .center
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(150)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(newsTableView)
        newsTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        newsTableView.backgroundColor = .tertiarySystemGroupedBackground
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(2)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
        }
    }
    
    func injectData(_ data: [Article]) {
        news = data
        newsTableView.reloadData()
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier,for: indexPath) as?TableViewCell else { return UITableViewCell() }
        if let data = news?[indexPath.row] {
            print(data)
            cell.recieveData(data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let data = news?[indexPath.row] {
            let url = URL(string: data.url ?? String())!
            loadWebView?(url)
        }
        
    }
}
