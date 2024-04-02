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
    @StateObject var viewModel = VideoViewModel()
    @State var selectedIndex: Int = 0
    @StateObject var player = PlayerViewModel()

    var body: some View {
        NavigationStack{
            VStack{
                if viewModel.videos.isEmpty {
                    Text("Loading...")
                        .font(.largeTitle)
                        .padding()
                        .bold()
                } else {
                    ZStack(content: {
                        VideoPlayer(player: self.player.player)
                        HStack {
                            //Previous Button
                            Button {
                                selectedIndex = selectedIndex-1
                                player.loadVideo(fromURL: viewModel.videos[selectedIndex].fullURL ?? "")
                            } label: {
                                if selectedIndex == 0 {
                                    Image("previous", bundle: nil)
                                        .font(.largeTitle)
                                        .frame(width:80, height: 80)
                                        .opacity(0.5)
                                } else {
                                    Image("previous", bundle: nil)
                                        .font(.largeTitle)
                                        .frame(width:80, height: 80)
                                }
                            }
                            .padding()
                            .disabled(selectedIndex == 0)
                            
                            //Play-Pause Button
                            if self.player.isPlaying {
                                Button {
                                    self.player.pauseVideo()
                                } label: {
                                    Image("pause", bundle: nil)
                                        .font(.largeTitle)
                                        .frame(width:80, height: 80)
                                }
                            } else {
                                Button {
                                    self.player.playVideo()
                                } label: {
                                    Image("play", bundle: nil)
                                        .font(.largeTitle)
                                        .frame(width:80, height: 80)
                                }
                            }

                            //Next Button
                            Button {
                                selectedIndex = selectedIndex+1
                                player.loadVideo(fromURL: viewModel.videos[selectedIndex].fullURL ?? "")
                            } label: {
                                if selectedIndex >= viewModel.videos.count-1 {
                                    Image("next", bundle: nil)
                                        .font(.largeTitle)
                                        .frame(width:80, height: 80)
                                        .opacity(0.5)
                                } else {
                                    Image("next", bundle: nil)
                                        .font(.largeTitle)
                                        .frame(width:80, height: 80)
                                }
                            }
                            .padding()
                            .disabled(selectedIndex >= viewModel.videos.count-1)
                        }
                    })
                    //Title and Description
                    ScrollView(content: {
                        Text(self.viewModel.videos[selectedIndex].title ?? "")
                            .bold()
                            .multilineTextAlignment(.leading)
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
                        Text("by  \(self.viewModel.videos[selectedIndex].author?.name ?? "")")
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            .multilineTextAlignment(.leading)
                        let descString = AttributedString(MarkdownParser().parse(self.viewModel.videos[selectedIndex].description ?? ""))
                        Text(descString).padding()
                    })
                }
            }
            .navigationTitle("Video Player")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.gray)
            .toolbarColorScheme(.dark)
            .toolbar(.visible, for: .navigationBar)
        }
        .task {
            await viewModel.getVideos()
            player.loadVideo(fromURL: viewModel.videos[selectedIndex].fullURL ?? "")
            selectedIndex = 0
        }
    }
}

#Preview {
    VideoView()
}
