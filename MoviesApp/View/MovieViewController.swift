//
//  ViewController.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var castLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getMovie(withId: movieId)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(castLabel)
        view.addSubview(directorLabel)
        view.addSubview(ratingLabel)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            imageView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            
            castLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            castLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            castLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            
            directorLabel.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 16),
            directorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            directorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            
            ratingLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 16),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            
        ])
    }
    
    private var viewModel: MovieViewModel
    var movieId: String
    
    init(viewModel: MovieViewModel, movieId: String) {
        self.viewModel = viewModel
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieViewController: MovieViewDelegate {
    func setMovie(movie: Movie) {
        DispatchQueue.main.async {
            let url = URL(string: movie.poster)
            self.imageView.kf.setImage(with: url)
            self.titleLabel.text = movie.title
            self.castLabel.text = movie.actors
            self.directorLabel.text = movie.director
            self.ratingLabel.text = movie.imdbRating
        }
    }
}

extension MovieViewController {
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
}
