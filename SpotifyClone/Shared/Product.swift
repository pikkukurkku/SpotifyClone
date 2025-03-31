//
//  Product.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 31.03.25.
//

import Foundation


struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}


struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let images: [String]
    let thumbnail: String
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
}

//enum Category: String, CaseIterable {
//    case all, music, podcasts, audiobooks
//}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    var title: String
    let products: [Product]
}
