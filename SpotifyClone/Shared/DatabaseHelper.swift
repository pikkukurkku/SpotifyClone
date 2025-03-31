//
//  DatabaseHelper.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 31.03.25.
//

import Foundation


struct DatabaseHelper {
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let jsonString = String(data: data, encoding: .utf8) {
               print("Raw JSON Response: \(jsonString)")
           }
        do {
        let products = try JSONDecoder().decode(ProductArray.self, from: data)
        return products.products
    }
        catch let DecodingError.keyNotFound(key, context) {
                    print("❌ Missing Key: \(key.stringValue) - \(context.debugDescription)")
                } catch let DecodingError.typeMismatch(type, context) {
                    print("❌ Type Mismatch: \(type) - \(context.debugDescription)")
                } catch let DecodingError.valueNotFound(type, context) {
                    print("❌ Value Not Found: \(type) - \(context.debugDescription)")
                } catch {
                    print("❌ Other Decoding Error: \(error)")
                }
                
                return []  // ✅ Return an empty array if decoding fails
            }
    
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(UserArray.self, from: data)
        return users.users
    }
    
}
