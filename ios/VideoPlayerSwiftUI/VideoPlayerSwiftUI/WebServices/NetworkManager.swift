//
//  NetworkManager.swift
//  TopSongs
//
//  Created by Malavika Akhilesh on 29/03/24.
//

import Foundation

final class NetworkManager {

    static func getVideosList() async throws -> [Video] {
        let urlString = "http://localhost:4000/videos"  //URL
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidURL     //throw error if URL is null
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorCases.invalidResponse    // throw error if response is not success
        }
        
        do{
            let decoder = JSONDecoder()
            return try decoder.decode([Video].self, from: data) //parse the response and create the model
        } catch {
            throw ErrorCases.invalidData
        }
    }
    
}
