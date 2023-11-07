//
//  MovieListTableViewCell.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 7.11.2023.
//

import UIKit
import Kingfisher

class MovieListTableViewCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        return image
    }()
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
        
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBlurView()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(typeLabel)
                
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            posterImage.widthAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            yearLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 6),
            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
 
            typeLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 4),
            typeLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 6),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
        ])
    }
    
    func setupBlurView() {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.contentView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.layer.cornerRadius = 16
        blurView.clipsToBounds = true
        self.contentView.addSubview(blurView)
        self.contentView.sendSubviewToBack(blurView)
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
    }
    
    func configureCell(posterImage: String,titleLabel: String, yearLabel: String, typeLabel: String) {
        if let url = URL(string: posterImage){
            self.posterImage.kf.setImage(with: url)
        }
        self.titleLabel.text = titleLabel
        self.yearLabel.text = "(\(yearLabel))"
        self.typeLabel.text = typeLabel.capitalized
    }
}
