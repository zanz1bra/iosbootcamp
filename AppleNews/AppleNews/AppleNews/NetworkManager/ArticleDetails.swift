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
        
        view.backgroundColor = .systemGray
        
        setupView()
    }
    
    private func setupView() {
        guard let article = article else {return}
        
        let titleLabel = UILabel()
        titleLabel.text = article.title
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = UIFont(name: "Helvetica Bold", size: 24)
        titleLabel.textAlignment = .center
        
        let contentLabel = UILabel()
        contentLabel.text = article.content
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.font = UIFont(name: "Sans Serif", size: 15)
        contentLabel.textAlignment = .justified
        
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: article.urlToImage ?? ""))
        imageView.contentMode = .scaleAspectFit
        
        let urlLabel = UILabel()
        urlLabel.text = "Read more: \(article.url ?? "")"
        urlLabel.numberOfLines = 0
        urlLabel.lineBreakMode = .byWordWrapping
        urlLabel.textColor = .white
        urlLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openURL(_:)))
        urlLabel.addGestureRecognizer(tapGesture)
        urlLabel.font = UIFont(name: "Sans Serif", size: 8)
        urlLabel.textAlignment = .left
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, contentLabel, urlLabel, imageView])
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
    
    @objc private func openURL(_ sender: UITapGestureRecognizer) {
        guard let urlString = article?.url, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

