//
//  VideoView.swift
//  VideoPlayerSwiftUI
//
//  Created by Malavika Akhilesh on 28/03/24.
//

import SwiftUI
import AVKit
import MarkdownKit

struct VideoView: View {
    @ObservedObject var viewModel = VideoViewModel()

    @State private var player = AVPlayer()

    var body: some View {
        NavigationStack{
            VStack{
                VideoPlayer(player: player)
                    .onReceive(viewModel.$videos, perform: { _ in
                    guard let viewModelVideos = self.viewModel.videos, let url = URL(string: viewModelVideos[self.viewModel.selectedIndex ?? 0].fullURL ?? "") else {
                        return
                    }
                    player = AVPlayer(url: url)
                    player.play()
                })
                ScrollView(content: {
                    Text(self.viewModel.videos?[self.viewModel.selectedIndex ?? 0].title ?? "")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
                    Text("by  \(self.viewModel.videos?[self.viewModel.selectedIndex ?? 0].author?.name ?? "")")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .multilineTextAlignment(.leading)
                    let descString = AttributedString(MarkdownParser().parse(self.viewModel.videos?[self.viewModel.selectedIndex ?? 0].description ?? ""))
                    Text(descString).padding()
                })
            }
            .navigationTitle("Video Player")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.gray)
            .toolbarColorScheme(.dark)
            .toolbar(.visible, for: .navigationBar)
        }
        .task {
            await viewModel.getVideos()
            self.viewModel.selectedIndex = 0
        }
        .onDisappear(perform: {
            player.pause()
        })
    }
}

#Preview {
    VideoView()
}
