//
//  ArticleDetails.swift
//  AppleNews
//
//  Created by arturs.olekss on 17/11/2023.
//

import UIKit

class ArticleDetails: UIViewController{
    
    var article: Article?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
    }
    
    private func setupView() {
        guard let article = article else {return}
        
        let titleLabel = UILabel()
        titleLabel.text = article.title
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        let contentLabel = UILabel()
        contentLabel.text = article.content
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: article.urlToImage ?? ""))
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, contentLabel, imageView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20),
        ])
        
        
    }
}
