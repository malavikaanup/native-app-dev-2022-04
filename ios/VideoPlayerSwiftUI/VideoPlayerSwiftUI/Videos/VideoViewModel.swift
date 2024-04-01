//
//  VideoViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Malavika Akhilesh on 28/03/24.
//

import Foundation

@MainActor
final class VideoViewModel: ObservableObject {
    @Published var videos: [Video]?
    @Published var selectedIndex: Int?
    
    func getVideos() async {
        do {
            let _videos = try await NetworkManager.getVideosList()
            self.videos = _videos
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}
