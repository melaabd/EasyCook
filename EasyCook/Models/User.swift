//
//  User.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation

struct User: Codable {
    var name: String
    var imageURL: String?

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
    }
}
