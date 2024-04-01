//
//  ErrorCases.swift
//  TopSongs
//
//  Created by Malavika Akhilesh on 29/03/24.
//

import Foundation

enum ErrorCases: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case custom(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL!"
        case .invalidResponse:
            return "Invalid Response!"
        case .invalidData:
            return "Invalid Data!"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
