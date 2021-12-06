//
//  NetworkService.swift
//  NewsTestApp
//
//  Created by Никита  on 25.10.2021.
//

import Foundation

class NetworkService {
    
    static var shared = NetworkService()
    private init() { }
    
    func fetchNews(from url: String?, with completion: @escaping (News?, Error?) -> Void) {
        guard let stringUrl = url else { return }
        guard let url = URL(string: stringUrl) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(DataService().token, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let data = data {
                do {
                    let news = try JSONDecoder().decode(News.self, from: data)
                    DispatchQueue.main.async {
                        completion(news, nil)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }  
        }.resume()
    }
}
