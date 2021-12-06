//
//  ViewController.swift
//  NewsTestApp
//
//  Created by Никита  on 25.10.2021.
//

import UIKit
import RealmSwift

class NewsListViewController: UITableViewController {
    
    var savedNews: Results<News>? = nil
    var storage = StorageService.shared
    var data = DataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        self.tableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: "cell")
        fetchNews()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navBarApperaence = UINavigationBarAppearance()
        navBarApperaence.configureWithOpaqueBackground()
        navBarApperaence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperaence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperaence.backgroundColor = .black
        
        navigationController?.navigationBar.standardAppearance = navBarApperaence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApperaence
        navigationController?.navigationBar.alpha = 1
    }
    
    private func fetchNews() {
        NetworkService.shared.fetchNews(from: data.stringURL) { (news, error)  in
            
            if error != nil {
                self.savedNews = self.storage.loadNews()
            } else {
                DispatchQueue.global().async {
                    self.storage.saveNews(news: news!)
                }
                self.savedNews = self.storage.loadNews()
            }
            self.tableView.reloadData()
        }
    }
}

extension NewsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedNews?.first?.news.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let news = savedNews?.first
        let newsDetails = news?.news
        let detail = newsDetails?.elements[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = detail?.title
//        content.secondaryText = detail?.plot
        content.imageProperties.maximumSize = CGSize(width: 80, height: 60)
        content.image = SupportService.shared.checkImageUrlAndReturnImage(
            imageURL: detail!.image,
            imageData: detail?.imageData
        )
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let details = savedNews?.first?.news[indexPath.row]
        goToDetailsNewsViewController(details: details!)
    }
}

extension NewsListViewController {
    
    private func goToDetailsNewsViewController(details: Details) {
        let detailsNewsVC = DetailsNewsViewController()
        let detailsNewsVCNavigationController = UINavigationController(rootViewController: detailsNewsVC)
        detailsNewsVCNavigationController.modalPresentationStyle = .fullScreen
        detailsNewsVC.details = details
        
        show(detailsNewsVC, sender: nil)
    }
}


