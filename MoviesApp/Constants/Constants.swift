//
//  Constants.swift
//  MoviesApp
//
//  Created by Seyit Murat Kaya on 6.11.2023.
//

import Foundation

struct Constants {
    struct Paths {
        static let baseUrl = "https://www.omdbapi.com/?apikey="
        static let id = "&i="
        static let title = "&t="
        static let search = "&s="
        static let type = "&type="
        static let year = "&y="
    }
    
    struct Margin {
        static let large: CGFloat = 24
        static let regular: CGFloat = 12
        static let small: CGFloat = 4
    }
    
    struct Font {
        static let extraLarge: CGFloat = 30
        static let large: CGFloat = 22
        static let medium: CGFloat = 16
        static let medium2: CGFloat = 14
        static let regular: CGFloat = 12
    }
}
