//
//  NewsViewController.swift
//  NewsTestApp
//
//  Created by Никита  on 25.10.2021.
//
import Foundation
import RealmSwift
import UIKit

class News: Object, Decodable {
    
    @Persisted var news: List<Details>
    @Persisted var page: Int
    @Persisted var status: String
}

class Details: Object, Decodable {
    
    @Persisted var author: String
    @Persisted var category: List<String>
    @Persisted var plot: String
    @Persisted var id: String
    @Persisted var image: String
    @Persisted var language: String
    @Persisted var published: String
    @Persisted var title: String
    @Persisted var url: String
    @Persisted var imageData: Data?

    private enum CodingKeys: String, CodingKey {
        case author, category, plot = "description", id, image, language, published, title, url
    }
}
