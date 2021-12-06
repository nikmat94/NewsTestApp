//
//  ImageEditorService.swift
//  NewsTestApp
//
//  Created by Никита  on 26.11.2021.
//

import UIKit

class ImageEditorService {
    
    static var shared = ImageEditorService()
    private init () {}
    
    func fitImageForCurrentView(incomingImageView: UIImageView, viewWidth: CGFloat) -> UIImageView {

        let image = incomingImageView.image
        let ratioOfSidesImage = image!.size.width / image!.size.height
        
        incomingImageView.frame = CGRect(x: -50, y: 400, width: viewWidth - 20, height: (viewWidth - 20) / ratioOfSidesImage)
        
        return incomingImageView
    }
    
}
