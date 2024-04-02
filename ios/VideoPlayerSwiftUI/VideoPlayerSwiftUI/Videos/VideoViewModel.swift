//
//  VideoViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Malavika Akhilesh on 28/03/24.
//

import Foundation
import AVKit

@MainActor
final class VideoViewModel: ObservableObject {
    @Published var videos: [Video] = []
    
    func getVideos() async {
        do {
            let _videos = try await NetworkManager.getVideosList()
            self.videos = _videos
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}

class PlayerViewModel: ObservableObject {
    @Published var player = AVPlayer()
    @Published var isPlaying = false
    
    func loadVideo(fromURL: String) {
        guard let videoURL = URL(string: fromURL) else { return }
        let playerItem = AVPlayerItem(url: videoURL)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        isPlaying = true
    }
    
    func playVideo() {
        player.play()
        isPlaying = true
    }
    
    func pauseVideo() {
        player.pause()
        isPlaying = false
    }
    
}
