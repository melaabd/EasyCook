//
//  Step.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import Foundation

struct Step: Codable {
    var stepDescription: String?
    var imageUrls: [String]?

    enum CodingKeys: String, CodingKey {
        case stepDescription = "description"
        case imageUrls = "image_urls"
    }
}
