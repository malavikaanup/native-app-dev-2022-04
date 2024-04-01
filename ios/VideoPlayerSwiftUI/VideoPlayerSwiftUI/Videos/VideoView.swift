//
//  VideoView.swift
//  VideoPlayerSwiftUI
//
//  Created by Malavika Akhilesh on 28/03/24.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @State private var player = AVPlayer()
    @State private var videoModel: Video?
    
    var body: some View {
        NavigationStack{
            VStack{
                VideoPlayer(player: player)
//                    .ignoresSafeArea(.all)
//                    .navigationBarBackButtonHidden()
                    .onAppear{
                        guard let url = URL(string: "https://embed-ssl.wistia.com/deliveries/cc8402e8c16cc8f36d3f63bd29eb82f99f4b5f88/accudvh5jy.mp4") else {
                            return
                        }
                        player = AVPlayer(url: url)
                        player.play()
                    }
                    .onDisappear{
                        player.pause()
                    }
                ScrollView(content: {
                    Text("While the Stack Exchange API offers the convenience of configuring and running API calls directly within its endpoint documentation pages, not all APIs provide such a feature.\n\nYou may sometimes load an API endpoint URL in your web browser to view its result, but this approach doesn’t work for authenticated HTTP requests or those with specific headers or a request body.\n\nFor a more versatile solution, you can run your Swift code in a playground to observe how an API responds to a request. Additionally, you have a couple of other options:\nThe first one is the cURL command line tool. Some API documentations provide sample cURL commands that you can copy and paste into your terminal.\n\n\nWhile the Stack Exchange API offers the convenience of configuring and running API calls directly within its endpoint documentation pages, not all APIs provide such a feature.\n\nYou may sometimes load an API endpoint URL in your web browser to view its result, but this approach doesn’t work for authenticated HTTP requests or those with specific headers or a request body.\n\nFor a more versatile solution, you can run your Swift code in a playground to observe how an API responds to a request. Additionally, you have a couple of other options:\nThe first one is the cURL command line tool. Some API documentations provide sample cURL commands that you can copy and paste into your terminal.")
                        .padding()
                })
            }
            .navigationTitle("Video Player")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.gray)
            .toolbarColorScheme(.dark)
            .toolbar(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    VideoView()
}
