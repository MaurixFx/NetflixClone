//
//  Media.swift
//  NetflixClone
//
//  Created by Mauricio Figueroa on 06-05-24.
//

import Foundation

struct MediaContent: Identifiable, Equatable, Codable {
    let title: String
    let media: [Media]
    
    var id: String {
        return "\(title)-id"
    }
}

struct Media: Identifiable, Hashable, Equatable, Codable {
    let title: String
    let imageURL: String
    let categories: [Category]
    let isRecentlyAdded: Bool
    
    var id: String {
        return "\(title)-\(imageURL)"
    }
}

enum Category: String, Hashable, Codable {
    case comedy
    case romantic
    case action
    case thriller
    case horror
    case drama
    case superhero
    case scienceFiction
    case crime
    case fantasy
}
