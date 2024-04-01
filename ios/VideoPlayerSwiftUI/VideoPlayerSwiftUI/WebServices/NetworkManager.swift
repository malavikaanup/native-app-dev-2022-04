//
//  NetworkManager.swift
//  TopSongs
//
//  Created by Malavika Akhilesh on 29/03/24.
//

import Foundation

final class NetworkManager {
    
    static func getSongs(limit: Int) async throws -> [SongList] {
        guard let url = URL(string: Constants.urlString(limit: limit)) else {
            throw ErrorCases.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorCases.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            let song = try decoder.decode(Songs.self, from: data)
            guard let songs = song.feed?.results else {
                return []
            }
            return songs
        } catch {
            throw ErrorCases.invalidData
        }
    }
    
}
