//
//  StorageService.swift
//  NewsTestApp
//
//  Created by Никита  on 29.10.2021.
//

import RealmSwift
import UIKit

class StorageService {
    
    static var shared = StorageService()
    private init() { }
    
    func saveNews(news: News) {
        let config = Realm.Configuration(
            schemaVersion: 3)
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
        
        try! realm.write({
            realm.deleteAll()
            realm.add(makeDetailWithImageData(news: news))
        })
    }
    
    func loadNews() -> Results<News> {
        let config = Realm.Configuration(
            schemaVersion: 3)
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
        return realm.objects(News.self)
    }
    
    func makeDetailWithImageData(news: News) -> News {
        
        let newsWithImageData = News()
        
        for details in news.news {
            let imageURL = URL(string: details.image)
            
            do {
                try details.imageData = Data(contentsOf: (imageURL ?? DataService().notFoundImageURL!))
            } catch {
                details.imageData = nil
            }
            
            newsWithImageData.news.append(details)
        }
        
        newsWithImageData.page = news.page
        newsWithImageData.status = news.status
        
        return newsWithImageData
    }
    
}
