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
    let category: Category
    let price, discountPercentage, rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?
    let sku: String
    let weight: Int
    let dimensions: Dimensions
    let warrantyInformation, shippingInformation: String
    let availabilityStatus: AvailabilityStatus
    let reviews: [Review]
    let returnPolicy: ReturnPolicy
    let minimumOrderQuantity: Int
    let meta: Meta
    let images: [String]
    let thumbnail: String
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Example product title",
            description: "This is some product description that goes here.",
            category: .beauty,
            price: 999,
            discountPercentage: 15,
            rating: 4.5,
            stock: 50,
            tags: ["hu", "ra"],
            brand: "Apple",
            sku: "sku",
            weight: 50,
            dimensions: Dimensions.mock,
            warrantyInformation: "info",
            shippingInformation: "info",
            availabilityStatus: .inStock,
            reviews: Review.mock,
            returnPolicy: .noReturnPolicy,
            minimumOrderQuantity: 50,
            meta: Meta.mock,
            images: [Constants.randomImage, Constants.randomImage, Constants.randomImage ],
            thumbnail: Constants.randomImage
        )
    }
    
}

enum AvailabilityStatus: String, Codable {
    case inStock = "In Stock"
    case lowStock = "Low Stock"
}

enum Category: String, Codable {
    case beauty = "beauty"
    case fragrances = "fragrances"
    case furniture = "furniture"
    case groceries = "groceries"
}

// MARK: - Dimensions
struct Dimensions: Codable {
    let width, height, depth: Double
    
    static var mock: Dimensions {
         Dimensions(
             width: 10.5,
             height: 20.0,
             depth: 5.0
         )
     }
}

// MARK: - Meta
struct Meta: Codable {
    let createdAt, updatedAt: CreatedAt
    let barcode: String
    let qrCode: String
    
    static var mock: Meta {
        Meta(
            createdAt: .the20240523T085621618Z,
            updatedAt: .the20240523T085621618Z,
            barcode: "3325493172934",
            qrCode: "https://assets.dummyjson.com/public/qr-code.png"
        )
    }
}

enum CreatedAt: String, Codable {
    case the20240523T085621618Z = "2024-05-23T08:56:21.618Z"
    case the20240523T085621619Z = "2024-05-23T08:56:21.619Z"
    case the20240523T085621620Z = "2024-05-23T08:56:21.620Z"
}

enum ReturnPolicy: String, Codable {
    case noReturnPolicy = "No return policy"
    case the30DaysReturnPolicy = "30 days return policy"
    case the60DaysReturnPolicy = "60 days return policy"
    case the7DaysReturnPolicy = "7 days return policy"
    case the90DaysReturnPolicy = "90 days return policy"
}

// MARK: - Review
// MARK: - Review
struct Review: Codable {
    let rating: Int
    let comment: String
    let date: CreatedAt
    let reviewerName, reviewerEmail: String

    static var mock: [Review] {  // ✅ Now returns an array of reviews
        [
            Review(
                rating: 5,
                comment: "Amazing product! Exceeded my expectations.",
                date: .the20240523T085621618Z,
                reviewerName: "John Doe",
                reviewerEmail: "john.doe@example.com"
            ),
            Review(
                rating: 5,
                comment: "Great product!",
                date: .the20240523T085621620Z,
                reviewerName: "Elena Baker",
                reviewerEmail: "elena.baker@x.dummyjson.com"
            ),
            Review(
                rating: 5,
                comment: "Highly impressed!",
                date: .the20240523T085621620Z,
                reviewerName: "Madeline Simpson",
                reviewerEmail: "madeline.simpson@x.dummyjson.com"
            ),
            Review(
                rating: 5,
                comment: "Very happy with my purchase!",
                date: .the20240523T085621620Z,
                reviewerName: "Caleb Nelson",
                reviewerEmail: "caleb.nelson@x.dummyjson.com"
            )
        ]
    }
}


//enum Category: String, CaseIterable {
//    case all, music, podcasts, audiobooks
//}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    var titleText: String
    let products: [Product]
}
