//
//  ViewController.swift
//  AppleNews
//
//  Created by arturs.olekss on 17/11/2023.
//

import UIKit
import SDWebImage

class NewsFeedController: UITableViewController {
    
    private var cellID = "cell"
    private var newsItems:[Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getNewsData()
    }
    
    private func setupView(){
        title = "News"
        view.backgroundColor = .secondarySystemBackground
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: cellID)
        tableView.rowHeight = 200
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.label]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func getNewsData(){
        NetworkManager.fetchData(url: NetworkManager.api){
            newsItems in
            self.newsItems = newsItems.articles ?? []
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
}

extension NewsFeedController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        
        let article = self.newsItems[indexPath.row]
        
        let titleLabel = UILabel()
        titleLabel.text = article.title ?? ""
        
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string:article.urlToImage ?? ""))
        
        let stackView = UIStackView(arrangedSubviews: [imageView,titleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        cell.addSubview(stackView)
        return cell
    }
}

