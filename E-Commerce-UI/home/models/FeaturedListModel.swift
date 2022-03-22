//
//  FeaturedListModel.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/13/22.
//

import Foundation

// MARK: - FeaturedList
struct FeaturedListModelElement: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let featuredListModelDescription: String?
    let category: Category?
    let image: String?
    let rating: Rating?

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case featuredListModelDescription = "description"
        case category, image, rating
    }
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}

typealias FeaturedListModel = [FeaturedListModelElement]
