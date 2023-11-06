//
//  ViewController.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import UIKit

class MovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebManager().fetchMovie(withId: "tt0372784") { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }


}

