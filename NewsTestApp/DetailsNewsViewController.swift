//
//  DetalsNewsViewController.swift
//  NewsTestApp
//
//  Created by Никита  on 24.11.2021.
//

import UIKit

class DetailsNewsViewController: UIViewController {
    
    var details: Details?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = details?.title
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-bold", size: 20)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = details?.plot
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 15)
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = details?.author
        label.numberOfLines = 1
        label.font = UIFont(name: "Helvetica-bold", size: 15)
        return label
    }()
    
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        let imageURL = details?.image
        let imageData = details?.imageData
        
        imageView.image = SupportService.shared.checkImageUrlAndReturnImage(
            imageURL: details!.image,
            imageData: details?.imageData
        )
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraint()
    }
    
    private func setupNavigationBar() {

        let navBarApperaence = UINavigationBarAppearance()
        navBarApperaence.configureWithOpaqueBackground()
        navBarApperaence.backgroundColor = .white
        
        navigationController?.navigationBar.standardAppearance = navBarApperaence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApperaence
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.alpha = 0.2
    }
    
    func setupView() {
        view.backgroundColor = .white
        setupSubViews(subviews:
                        titleLabel,
                        descriptionLabel,
                        authorLabel,
                        imageView)
    }
    
    func setupSubViews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            imageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            imageView.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.bottomAnchor, multiplier: 0)
        ])
    }
}
