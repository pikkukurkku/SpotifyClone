//
//  User.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 31.03.25.
//

import Foundation


struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}


struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    static var mock: User {
        User(
            id: 123,
            firstName: "Natalia",
            lastName: "Ogorek",
            age: 36,
            email: "nat@nat.com",
            phone: "",
            username: "",
            password: "",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
}
