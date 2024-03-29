//
//  VideoModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Malavika Akhilesh on 28/03/24.
//

import Foundation

// MARK: - Video
struct Video: Codable {
    let id, title: String?
    let hlsURL: String?
    let fullURL: String?
    let description, publishedAt: String?
    let author: Author?
}

// MARK: - Author
struct Author: Codable {
    let id, name: String?
}
