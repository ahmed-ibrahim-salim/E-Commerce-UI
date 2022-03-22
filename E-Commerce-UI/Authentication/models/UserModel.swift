//
//  UserModle.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/17/22.
//

import Foundation

struct User: Codable {
    let address: Address?
    let id: Int?
    let email, username, password: String?
    let name: Name?
    let phone: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case address, id, email, username, password, name, phone
        case v = "__v"
    }
}

// MARK: - Address
struct Address: Codable {
    let geolocation: Geolocation?
    let city, street: String?
    let number: Int?
    let zipcode: String?
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let lat: String?
    let long: String?
}

// MARK: - Name
struct Name: Codable {
    let firstname, lastname: String?
}
