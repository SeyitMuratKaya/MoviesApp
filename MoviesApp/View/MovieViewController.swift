//
//  ViewController.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        viewModel.getMovie(withId: movieId)
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
        
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private lazy var blurImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: Constants.Font.extraLarge)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var runtimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var imdbLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.imdblogo
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .systemBackground
        button.setTitle(" Play", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var divider1: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .secondaryLabel
        return divider
    }()
    
    private lazy var addToListAction = makeAction(withImage: "plus", withTitle: "Add To List")
    private lazy var rateAction = makeAction(withImage: "heart", withTitle: "Rate")
    private lazy var downloadAction = makeAction(withImage: "square.and.arrow.down", withTitle: "Download")
    private lazy var shareAction = makeAction(withImage: "arrowshape.turn.up.right.fill", withTitle: "Share")
    
    private lazy var divider2: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .secondaryLabel
        return divider
    }()
    
    private lazy var plotLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Plot"
        label.font = UIFont.systemFont(ofSize: Constants.Font.large)
        return label
    }()
    
    private lazy var plotText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium)
        return label
    }()
    
    private lazy var castLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium2)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.Font.medium2)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var backButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .large
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .secondaryLabel
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var moreButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .large
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private func setupUI() {
        
        view.addSubview(blurImageView)
        view.addSubview(blurView)
        blurImageView.addSubview(blurView)
        view.addSubview(imageView)
        view.addSubview(backButton)
        view.addSubview(moreButton)
        view.addSubview(titleLabel)
        view.addSubview(yearLabel)
        view.addSubview(genreLabel)
        view.addSubview(runtimeLabel)
        view.addSubview(typeLabel)
        view.addSubview(imdbLogo)
        view.addSubview(ratingLabel)
        view.addSubview(playButton)
        view.addSubview(divider1)
        view.addSubview(addToListAction)
        view.addSubview(rateAction)
        view.addSubview(downloadAction)
        view.addSubview(shareAction)
        view.addSubview(divider2)
        view.addSubview(plotLabel)
        view.addSubview(plotText)
        view.addSubview(directorLabel)
        view.addSubview(castLabel)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Margin.small),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.small),
            
            moreButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Margin.small),
            moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.small),
            
            blurImageView.topAnchor.constraint(equalTo: view.topAnchor),
            blurImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            blurView.topAnchor.constraint(equalTo: blurImageView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: blurImageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: blurImageView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: blurImageView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.regular),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.Margin.regular),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Margin.small),
            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            genreLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: Constants.Margin.regular),
            genreLabel.leadingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.regular),
            
            runtimeLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: Constants.Margin.small),
            runtimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            typeLabel.topAnchor.constraint(equalTo: runtimeLabel.topAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: runtimeLabel.trailingAnchor, constant: Constants.Margin.small),
            
            imdbLogo.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: Constants.Margin.regular),
            imdbLogo.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            imdbLogo.heightAnchor.constraint(equalToConstant: 20),
            imdbLogo.widthAnchor.constraint(equalToConstant: 40),
            
            ratingLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: Constants.Margin.regular),
            ratingLabel.leadingAnchor.constraint(equalTo: imdbLogo.trailingAnchor, constant: Constants.Margin.small),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            playButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.Margin.regular),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.regular),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.regular),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            
            divider1.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: Constants.Margin.regular),
            divider1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.regular),
            divider1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.regular),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            addToListAction.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: Constants.Margin.large - 6),
            addToListAction.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addToListAction.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            
            rateAction.topAnchor.constraint(equalTo: addToListAction.topAnchor),
            rateAction.leadingAnchor.constraint(equalTo: addToListAction.trailingAnchor),
            rateAction.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            
            downloadAction.topAnchor.constraint(equalTo: addToListAction.topAnchor),
            downloadAction.leadingAnchor.constraint(equalTo: rateAction.trailingAnchor),
            downloadAction.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            
            shareAction.topAnchor.constraint(equalTo: addToListAction.topAnchor),
            shareAction.leadingAnchor.constraint(equalTo: downloadAction.trailingAnchor),
            shareAction.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shareAction.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            
            divider2.topAnchor.constraint(equalTo: shareAction.bottomAnchor, constant: Constants.Margin.large),
            divider2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.regular),
            divider2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.regular),
            divider2.heightAnchor.constraint(equalToConstant: 1),
            
            plotLabel.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: Constants.Margin.regular),
            plotLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.regular),
            plotLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.regular),
            
            plotText.topAnchor.constraint(equalTo: plotLabel.bottomAnchor, constant: Constants.Margin.regular),
            plotText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.regular),
            plotText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.regular),
            
            directorLabel.topAnchor.constraint(equalTo: plotText.bottomAnchor, constant: Constants.Margin.regular),
            directorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.regular),
            directorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.regular),
            
            castLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: Constants.Margin.regular),
            castLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.regular),
            castLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.regular),
        ])
    }
    
    private func makeAction(withImage image: String, withTitle title: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        var config = UIButton.Configuration.plain()
        config.buttonSize = .medium
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: image), for: .normal)
        button.tintColor = .label
        button.tintColor = .label
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = UIFont.systemFont(ofSize: Constants.Font.regular)
        label.textColor = .secondaryLabel
        
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(label)
        
        return stackView
    }
    
}

extension MovieViewController: MovieViewDelegate {
    func setMovie(movie: Movie) {
        DispatchQueue.main.async {
            let url = URL(string: movie.poster)
            self.imageView.kf.setImage(with: url)
            self.blurImageView.kf.setImage(with: url)
            self.titleLabel.text = movie.title
            self.yearLabel.text = "(\(movie.year))"
            self.genreLabel.text = movie.genre
            self.runtimeLabel.text = movie.runtime.replacingOccurrences(of: " ", with: "")
            self.typeLabel.text = movie.type.capitalized
            self.ratingLabel.text = "\(movie.imdbRating)/10"
            self.plotText.text = movie.plot
            self.directorLabel.text = "Director: \(movie.director)"
            self.castLabel.text = "Actors: \(movie.actors)"
        }
    }
    
    func setErrors() {
        
    }
}

extension MovieViewController {
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
}
