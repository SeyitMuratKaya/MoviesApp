//
//  MovieListViewController.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import UIKit

class MovieListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "no movies found"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.getMovies(for: "the batman")
        setupUI()
        setupSearchController()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Movies"
        self.searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private let viewModel: MovieListViewModel
    private var movies: Movies?
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieListViewController: MovieListViewDelegate {
    func setErrors() {
        DispatchQueue.main.async {
            self.movies = nil
            self.tableView.isHidden = true
            self.errorLabel.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func setMovies(movies: Movies) {
        DispatchQueue.main.async {
            print(movies)
            self.movies = movies
            self.tableView.isHidden = false
            self.errorLabel.isHidden = true
            self.tableView.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies?.search.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        cell.configureCell(posterImage: movies?.search[indexPath.row].poster ?? "",titleLabel: movies?.search[indexPath.row].title ?? "", yearLabel: movies?.search[indexPath.row].year ?? "", typeLabel: movies?.search[indexPath.row].type.rawValue ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let networkManager: NetworkManagerProtocol = WebManager()
        let viewModel = MovieViewModel(networkManager: networkManager)
        let vc = MovieViewController(viewModel: viewModel, movieId: movies?.search[indexPath.row].imdbID ?? "")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.getMovies(for: searchBar.text ?? "")
    }
}
