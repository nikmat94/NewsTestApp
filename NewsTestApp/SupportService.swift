//
//  SupportService.swift
//  NewsTestApp
//
//  Created by Никита  on 30.11.2021.
//

import UIKit

class SupportService {
    
    static var shared = SupportService()
    private init () {}
    
    func checkImageUrlAndReturnImage(imageURL: String, imageData: Data?) -> UIImage {
        switch imageURL {
        case "None", "": return UIImage(named: "Image404")!
        default:
            switch imageData {
            case nil: return UIImage(named: "Image404")!
            default: return UIImage(data: (imageData!))!
            }
        }
    }
}
