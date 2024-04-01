//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = VideoViewModel()
    var body: some View {
        VideoView()
            .task {
                await viewModel.getVideos()
            }
//            .onAppear(perform: {
//                Task {
//                    await viewModel.getVideos()
//                }
//            })
        // above 2 ways to call an asynchronous call
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
