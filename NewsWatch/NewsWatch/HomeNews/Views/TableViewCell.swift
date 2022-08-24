//
//  TableViewCell.swift
//  NewsWatch
//
//  Created by  Ugo  Val on 20/08/2022.
//

protocol ReuseIdentifying {
  static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
  static var reuseIdentifier: String { return String(describing: Self.self) }
}


import UIKit
import SnapKit


class TableViewCell: UITableViewCell,ReuseIdentifying {

    fileprivate let newsImageView = UIImageView()
    fileprivate let newsheader = UILabel()
    fileprivate let newsAuthor = UILabel()
    
    // MARK: - INITIALIZERS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
      selectionStyle = .none
      contentView.addSubview(newsImageView)
        contentView.addSubview(newsAuthor)
        contentView.addSubview(newsheader)
        
        contentView.backgroundColor = .tertiarySystemGroupedBackground
       
        newsImageView.backgroundColor = .blue
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right).offset(-3)
            make.left.equalTo(contentView.snp.left).offset(3)
            make.height.equalTo(150)
            make.bottom.equalTo(contentView.snp.bottom).offset(-3)
           
        }
        
        
        newsheader.text = String()
        newsheader.lineBreakMode = .byWordWrapping
        newsheader.numberOfLines = 0
        newsheader.font = .systemFont(ofSize: 16, weight: .bold)
        newsheader.snp.makeConstraints { make in
            make.bottom.equalTo(newsAuthor.snp.top).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(25)
            make.right.equalTo(contentView.snp.right).offset(-25)
        }
        
        
        newsAuthor.text = String()
      
        newsAuthor.font = .systemFont(ofSize: 12, weight: .thin)
        newsAuthor.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(25)
            make.right.equalTo(contentView.snp.right).offset(-25)
            make.bottom.equalTo(newsImageView.snp.bottom).offset(-10)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func recieveData(_ data: Article) {
        newsheader.text = data.title
        newsAuthor.text = data.author
        newsImageView.downloadImage(from: data.urlToImage ?? String())
    }
}
